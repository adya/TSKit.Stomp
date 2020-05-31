import Foundation
import Starscream

public protocol AnyStompServiceDelegate: class {
    
    func serviceDidConnect(_ service: StompService)
    
    func service(_ service: StompService, didReceive error: Error)
    
    func service(_ service: StompService, didReceive data: Data)
    
    func service(_ service: StompService, didReceive message: String)
}

public class StompService {
    
    public weak var delegate: AnyStompServiceDelegate?
    
    let socket: WebSocket
    
    init(url: URL) {
        socket = WebSocket(request: URLRequest(url: url))
    }
    
    init(request: URLRequest) {
        socket = WebSocket(request: request)
    }
    
    public func connect() {
        socket.connect()
    }
    
    public func disconnect() {
        socket.disconnect()
    }
    
    private func sendFrame(_ frame: Frame) {
        
    }
}

extension StompService: WebSocketDelegate {
    
    public func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let t):
            break
            case .disconnected(_, _):
            break
            case .text(let text):
            break
            case .binary(let data):
            break
            case .pong(let payload):
            break
            case .ping(let payload):
            break
            case .error(let error):
            break
            case .viabilityChanged(let flag):
            break
            case .reconnectSuggested(let flag):
            break
            case .cancelled: break
        }
    }
}
