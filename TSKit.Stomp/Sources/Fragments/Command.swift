/// Commands that can be received from server.
enum ServerCommand: CustomStringConvertible {
   
    case connected
    case message
    case receipt
    case error
    
    case custom(String)
    
    var description: String {
        switch self {
            case .connected: return String(describing: Stomp.ServerCommand.connected)
            case .message: return String(describing: Stomp.ServerCommand.message)
            case .receipt: return String(describing: Stomp.ServerCommand.receipt)
            case .error: return String(describing: Stomp.ServerCommand.error)
            case .custom(let command): return command.uppercased()
        }
    }
}

/// Commands that can be sent to server.
enum ClientCommand: CustomStringConvertible {
    
    case connect
    case stomp
    case disconnect
    
    case send
    
    case subscribe
    case unsubscribe
    
    case begin
    case commit
    case abort
    case ack
    case nack
    
    case custom(String)
    
    var description: String {
        switch self {
            case .connect: return String(describing: Stomp.ClientCommand.connect)
            case .stomp: return String(describing: Stomp.ClientCommand.stomp)
            case .disconnect: return String(describing: Stomp.ClientCommand.disconnect)
            case .send: return String(describing: Stomp.ClientCommand.send)
            case .subscribe: return String(describing: Stomp.ClientCommand.subscribe)
            case .unsubscribe: return String(describing: Stomp.ClientCommand.unsubscribe)
            case .begin: return String(describing: Stomp.ClientCommand.begin)
            case .commit: return String(describing: Stomp.ClientCommand.commit)
            case .abort: return String(describing: Stomp.ClientCommand.abort)
            case .ack: return String(describing: Stomp.ClientCommand.ack)
            case .nack: return String(describing: Stomp.ClientCommand.nack)
            case .custom(let command): return command.uppercased()
        }
    }
}
