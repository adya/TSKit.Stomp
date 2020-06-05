struct MessageFrame: AnyServerFrame, AnyPayloadFrame {
    
    let command: ServerCommand = .message
    
    /// Required:
    /// - cotent-length
    /// - content-type
    /// - destination
    /// - message-id
    /// - subscription
    /// Optional:
    /// - ack
    let headers: Set<Header>
    
    let body: String?
}
