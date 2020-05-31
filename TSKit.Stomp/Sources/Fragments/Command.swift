/// List of  valid server commands as of STOMP 1.2
enum ServerCommand: AnyFrameFragmentConvertible {
    
    case connected
    case message
    case receipt
    case error
    
    case custom(String)
    
    var fragment: String {
        switch self {
            case .connected: return StompCommand.connected.fragment
            case .message: return StompCommand.message.fragment
            case .receipt: return StompCommand.receipt.fragment
            case .error: return StompCommand.error.fragment
            case .custom(let command): return command.uppercased()
        }
    }
}

/// List of  valid client commands as of STOMP 1.2
enum ClientCommand: AnyFrameFragmentConvertible {
    
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
    
    var fragment: String {
        switch self {
            case .connect: return StompCommand.connect.fragment
            case .stomp: return StompCommand.stomp.fragment
            case .disconnect: return StompCommand.disconnect.fragment
            case .send: return StompCommand.send.fragment
            case .subscribe: return StompCommand.subscribe.fragment
            case .unsubscribe: return StompCommand.unsubscribe.fragment
            case .begin: return StompCommand.begin.fragment
            case .commit: return StompCommand.commit.fragment
            case .abort: return StompCommand.abort.fragment
            case .ack: return StompCommand.ack.fragment
            case .nack: return StompCommand.nack.fragment
            case .custom(let command): return command.uppercased()
        }
    }
}

/// List of all valid commands as of STOMP 1.2
private enum StompCommand: String, AnyFrameFragmentConvertible {
    
    case connected
    case message
    case receipt
    case error
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
    
    var fragment: String {
        rawValue.uppercased()
    }
}
