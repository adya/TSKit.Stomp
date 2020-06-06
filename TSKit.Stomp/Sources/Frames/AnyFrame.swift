protocol AnyFrame {
    
    var headers: Set<Header> { get }
}

protocol AnyClientFrame: AnyFrame {
    
    var command: ClientCommand { get }
}

protocol AnyServerFrame: AnyFrame {
    
    var command: ServerCommand { get }
}

protocol AnyPayloadFrame: AnyFrame {
    
    var body: String? { get }
}
