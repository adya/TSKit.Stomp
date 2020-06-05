struct ErrorFrame: AnyServerFrame {
    
    let command: ServerCommand = .error
    
    /// Optional:
    /// - message
    let headers: Set<Header>
}
