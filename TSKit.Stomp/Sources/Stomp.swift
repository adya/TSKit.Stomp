/// Namespace containing all STOMP terms.
public enum Stomp {}

public extension Stomp {
    
    /// Supported revisions of STOMP.
    static let versions = ["1.2"]
    
    /// List of all valid headers.
    enum Header: String {
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
    
    /// List of all valid acknowledge mode keywords.
    enum Acknowledge: String {
        case auto
        case client
        case clientIndividual = "client-individual"
    }
    
    /// List of all valid commands that can be sent to server.
    enum ClientCommand: String, CustomStringConvertible {
       
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
        
        public var description: String {
            rawValue.uppercased()
        }
    }
    
    enum ServerCommand: String, CustomStringConvertible {
        
        case connected
        case message
        case receipt
        case error
        
        public var description: String {
            rawValue.uppercased()
        }
    }
}
