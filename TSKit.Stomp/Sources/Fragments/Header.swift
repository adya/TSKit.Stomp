enum Header: Hashable, AnyFrameFragmentConvertible {
    
    case acceptVersion(_ versions: [String])
    
    case heartBeat(outgoingInterval: Int, expectedInterval: Int)
    
    case host(_ hostName: String)
    case destination(path: String)
    
    case version(version: String)
    case subscription(subId: String)
    case messageId(id: String)
    
    case contentLength(length: Int)
    case contentType(type: String)
    case receipt(_ receipt: String)
    
    case message(message: String)
    case login(_ login: String)
    case passcode(_ passcode: String)
    case id(_ id: String)
    case session(_ session: String)
    case server(_ server: String)
    case transaction(_ transaction: String)
    case ack(_ ack: Acknowledge)
    case receiptId(_ receipt: String)
    
    case custom(key: String, value: String)
    
    public var fragment: String { "\(key):\(value)" }
    
    var key: String {
        switch self {
            case .contentLength: return StompHeaders.contentLength.rawValue
            case .contentType: return StompHeaders.contentType.rawValue
            case .receipt: return StompHeaders.receipt.rawValue
            case .acceptVersion: return StompHeaders.acceptVersion.rawValue
            case .host: return StompHeaders.host.rawValue
            case .login: return StompHeaders.login.rawValue
            case .passcode: return StompHeaders.passcode.rawValue
            case .heartBeat: return StompHeaders.heartBeat.rawValue
            case .version: return StompHeaders.version.rawValue
            case .id: return StompHeaders.id.rawValue
            case .session: return StompHeaders.session.rawValue
            case .server: return StompHeaders.server.rawValue
            case .destination: return StompHeaders.destination.rawValue
            case .transaction: return StompHeaders.transaction.rawValue
            case .ack: return StompHeaders.ack.rawValue
            case .subscription: return StompHeaders.subscription.rawValue
            case .messageId: return StompHeaders.messageId.rawValue
            case .receiptId: return StompHeaders.receiptId.rawValue
            case .message: return StompHeaders.message.rawValue
            case .custom(let key, _): return key
        }
    }
    
    var value: String {
        switch self {
            case .acceptVersion(let versions): return versions.joined(separator: ",")
            case .heartBeat(let outgoing, let incoming): return "\(outgoing),\(incoming)"
            case .destination(let path): return path
            case .version(let version): return version
            case .subscription(let subId): return subId
            case .messageId(let id): return id
            case .contentLength(let length): return "\(length)"
            case .message(let body): return body
            case .contentType(let type): return type
            case .host(let host): return host
            case .custom(_, let value): return value
            case .receipt(let receipt): return receipt
            case .login(let login): return login
            case .passcode(let passcode): return passcode
            case .id(let id): return id
            case .session(let session): return session
            case .server(let server): return server
            case .transaction(let transaction): return transaction
            case .ack(let acknowledge): return acknowledge.rawValue
            case .receiptId(let id): return id
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
    
    // MARK: - Equatable
    public static func ==(lhs: Header, rhs: Header) -> Bool {
        lhs.key == rhs.key
    }
}

enum Acknowledge: String {
    case auto
    case client
    case clientIndividual = "client-individual"
}

/// List of all valid headers as of STOMP 1.2
private enum StompHeaders: String {
    
    // MARK: - Standard
    case contentLength = "content-length"
    case contentType = "content-type"
    case receipt
    
    case acceptVersion = "accept-version"
    case host
    
    case login
    case passcode
    case heartBeat = "heart-beat"
    case version
    
    case id
    case session
    case server
    case destination
    case transaction
    
    case ack
    
    
    case subscription
    case messageId = "message-id"
    case receiptId = "receipt-id"
    
    case message
}
