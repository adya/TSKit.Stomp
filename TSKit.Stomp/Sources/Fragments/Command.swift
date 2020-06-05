/// List of  valid server commands as of STOMP 1.2
enum ServerCommand: CustomStringConvertible, Decodable {
   
    case connected
    case message
    case receipt
    case error
    
    case custom(String)
    
    var description: String {
        switch self {
            case .connected: return StompCommand.connected.description
            case .message: return StompCommand.message.description
            case .receipt: return StompCommand.receipt.description
            case .error: return StompCommand.error.description
            case .custom(let command): return command.uppercased()
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let fragment = try container.decode(String.self)
        
        if let stomp = StompCommand(rawValue: fragment) {
            switch stomp {
                case .connected: self = .connected
                case .message: self = .message
                case .receipt: self = .receipt
                case .error: self = .error
                default: throw DecodingError.dataCorruptedError(in: container, debugDescription: "Recevied not server-side StompCommand '\(fragment)'")
            }
        } else {
            self = .custom(fragment)
        }
    }
}

/// List of  valid client commands as of STOMP 1.2
enum ClientCommand: CustomStringConvertible, Encodable {
    
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
            case .connect: return StompCommand.connect.description
            case .stomp: return StompCommand.stomp.description
            case .disconnect: return StompCommand.disconnect.description
            case .send: return StompCommand.send.description
            case .subscribe: return StompCommand.subscribe.description
            case .unsubscribe: return StompCommand.unsubscribe.description
            case .begin: return StompCommand.begin.description
            case .commit: return StompCommand.commit.description
            case .abort: return StompCommand.abort.description
            case .ack: return StompCommand.ack.description
            case .nack: return StompCommand.nack.description
            case .custom(let command): return command.uppercased()
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }
}

/// List of all valid commands as of STOMP 1.2
private enum StompCommand: String, CustomStringConvertible {
    
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
    
    var description: String {
        rawValue.uppercased()
    }
}
