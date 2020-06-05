struct ConnectedFrame: AnyServerFrame {
    
    let command: ServerCommand = .connected
    
    /// Required:
    /// - version
    /// Optional:
    /// - server
    /// - heart-beat
    /// - session
    let headers: Set<Header>
}
