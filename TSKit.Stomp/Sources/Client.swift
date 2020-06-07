import Foundation
import Starscream

public protocol AnyStompServiceDelegate: class {
    
    func serviceDidConnect(_ service: StompService)
        
    func service(_ service: StompService, didReceive frame: AnyServerFrame)
}

public final class StompService {
    
    public weak var delegate: AnyStompServiceDelegate?
    
    let socket: WebSocket
    
    private let decoder = StompDecoder()
    
    private let encoder = StompEncoder()
    
    private var isConnected = false
    
    public init(url: URL) {
        socket = WebSocket(request: URLRequest(url: url))
    }
    
    public init(request: URLRequest) {
        socket = WebSocket(request: request)
    }
    
    public func connect() {
        socket.connect()
    }
    
    public func disconnect() {
        socket.disconnect()
    }
    
    private func sendFrame(_ frame: AnyClientFrame) {
        guard isConnected else { return }
    }
}

extension StompService: WebSocketDelegate {
    
    public func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                print("Connected with headers: \(headers)")
                isConnected = true
            
            case .disconnected(_, _):
                isConnected = false
            
            case .text(let text):
                do {
                    let frame = try decoder.decode(text)
                    delegate?.service(self, didReceive: frame)
                } catch {
                    print("Sorry, no: \(error)")
            }
            
            case .reconnectSuggested(let flag):
                if flag {
                    client.disconnect()
                    client.connect()
                }
            
            case .error(let error):
                print(error as Any)
            
            case .viabilityChanged(let flag):
                print("Viability changed to \(flag)") // Idk what to do here
            
            case .cancelled:
                print("Cancelled event") // Idk what to do here
            
            case .binary: break // Not expecting data in STOMP
            case .ping, .pong: break // Automatically responded.
        }
    }
}
