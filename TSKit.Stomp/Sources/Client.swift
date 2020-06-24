import Foundation
import Starscream

public protocol AnyStompServiceDelegate: class {
    
    func serviceDidConnect(_ service: StompService)
    
    func serviceDidCancelConnection(_ service: StompService)
    
    func service(_ service: StompService, didFailWith error: Error?)
    
    func service(_ service: StompService, didReceive frame: AnyServerFrame)
}

public extension AnyStompServiceDelegate {
    
    func serviceDidConnect(_ service: StompService) {}
    
    func serviceDidCancelConnection(_ service: StompService) {}
    
    func service(_ service: StompService, didFailWith error: Error?) {}
}

public final class StompService {
    
    public weak var delegate: AnyStompServiceDelegate?
    
    let socket: WebSocket
    
    private let decoder = StompDecoder()
    
    private let encoder = StompEncoder()
    
    private var isConnected = false
        
    private var timer: Timer?
    
    public init(url: URL) {
        socket = WebSocket(request: URLRequest(url: url))
        socket.delegate = self
    }
    
    public init(request: URLRequest) {
        socket = WebSocket(request: request)
        socket.delegate = self
    }
    
    public func connect() {
        socket.connect()
    }
    
    public func disconnect() {
        stopHeartBeat()
        sendFrame(DisconnectFrame())
        socket.disconnect()
    }
    
    public func sendFrame(_ frame: AnyClientFrame) {
        guard isConnected else { return }
        socket.write(string: encoder.encode(frame))
    }
    
    private func stopHeartBeat() {
        timer?.invalidate()
        timer = nil
    }
}

extension StompService: WebSocketDelegate {
    
    public func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                print("Connected with headers: \(headers)")
                isConnected = true
                delegate?.serviceDidConnect(self)
            
            case .disconnected(_, _):
                isConnected = false
                stopHeartBeat()
            
            case .text(let text):
                do {
                    let frame = try decoder.decode(text)
                    if let frame = frame as? ConnectedFrame, let heartBeat = frame.headers.heartBeat, heartBeat.expected > 0 {
                        // Send heart-beat accordingly
                        timer = Timer.scheduledTimer(withTimeInterval: .init(heartBeat.expected),
                                                     repeats: true,
                                                     block: { [weak client] _ in
                            client?.write(data: "\n".data(using: .utf8)!)
                        })
                    }
                    delegate?.service(self, didReceive: frame)
                } catch {
                    print("\(Date()): Not a valid frame: '\(text)'")
                }
            
            case .reconnectSuggested(let flag):
                if flag {
                    client.connect()
                }
            
            case .error(let error):
                isConnected = false
                delegate?.service(self, didFailWith: error)
                client.connect()
                print(error as Any)
            
            case .viabilityChanged(let flag):
                print("Viability changed to \(flag)") // Idk what to do here
            
            case .cancelled:
                isConnected = false
                print("Cancelled event") // Idk what to do here
            
            case .binary: break // Not expecting data in STOMP
            case .ping, .pong: break // Automatically responded.
        }
    }
}
