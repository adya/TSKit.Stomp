public struct MessageFrame: AnyServerFrame {
    
    public let command: ServerCommand = .message
    
    /// Required:
    /// - cotent-length
    /// - content-type
    /// - destination
    /// - message-id
    /// - subscription
    /// Optional:
    /// - ack
    public let headers: HeaderSet
    
    public let body: String?
}
