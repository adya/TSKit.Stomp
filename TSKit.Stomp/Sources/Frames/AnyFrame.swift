public protocol AnyFrame {
    
    var headers: HeaderSet { get }
    
    var body: String? { get }
}

public protocol AnyClientFrame: AnyFrame {
    
    var command: ClientCommand { get }
}

public protocol AnyServerFrame: AnyFrame {
    
    var command: ServerCommand { get }
}

// MARK: - Empty body default
public extension AnyFrame {
    
    var body: String? { nil }
}
