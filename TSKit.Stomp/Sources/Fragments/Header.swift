enum Header: Hashable, CustomStringConvertible {
   
    case acceptVersion(_ versions: [String])
    
    case heartBeat(HeartBeat)
    
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
    case ack(_ ack: Stomp.Acknowledge)
    case receiptId(_ receipt: String)
    
    case custom(key: String, value: String)
    
    public var description: String { "\(key):\(value)" }
    
    var key: String {
        switch self {
            case .contentLength: return Stomp.Header.contentLength.rawValue
            case .contentType: return Stomp.Header.contentType.rawValue
            case .receipt: return Stomp.Header.receipt.rawValue
            case .acceptVersion: return Stomp.Header.acceptVersion.rawValue
            case .host: return Stomp.Header.host.rawValue
            case .login: return Stomp.Header.login.rawValue
            case .passcode: return Stomp.Header.passcode.rawValue
            case .heartBeat: return Stomp.Header.heartBeat.rawValue
            case .version: return Stomp.Header.version.rawValue
            case .id: return Stomp.Header.id.rawValue
            case .session: return Stomp.Header.session.rawValue
            case .server: return Stomp.Header.server.rawValue
            case .destination: return Stomp.Header.destination.rawValue
            case .transaction: return Stomp.Header.transaction.rawValue
            case .ack: return Stomp.Header.ack.rawValue
            case .subscription: return Stomp.Header.subscription.rawValue
            case .messageId: return Stomp.Header.messageId.rawValue
            case .receiptId: return Stomp.Header.receiptId.rawValue
            case .message: return Stomp.Header.message.rawValue
            case .custom(let key, _): return key
        }
    }
    
    var value: String {
        switch self {
            case .acceptVersion(let versions): return versions.joined(separator: ",")
            case .heartBeat(let heartbeat): return "\(heartbeat.guaranteed),\(heartbeat.expected)"
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

