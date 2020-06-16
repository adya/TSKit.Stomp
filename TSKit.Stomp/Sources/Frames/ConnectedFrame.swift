public struct ConnectedFrame: AnyServerFrame {
    
    public let command: ServerCommand = .connected
    
    /// Required:
    /// - version
    /// Optional:
    /// - server
    /// - heart-beat
    /// - session
    public let headers: HeaderSet
}
