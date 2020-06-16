public struct ErrorFrame: AnyServerFrame {
    
    public let command: ServerCommand = .error
    
    /// Optional:
    /// - message
    public let headers: HeaderSet
    
    public let body: String?
}
