struct MessageFrame: AnyServerFrame {
    
    let command: ServerCommand = .message
    
    /// Required:
    /// - cotent-length
    /// - content-type
    /// - destination
    /// - message-id
    /// - subscription
    /// Optional:
    /// - ack
    let headers: HeaderSet
    
    let body: String?
}
