struct ErrorFrame: AnyServerFrame {
    
    let command: ServerCommand = .error
    
    /// Optional:
    /// - message
    let headers: HeaderSet
    
    let body: String?
}
