protocol AnyFrame {
    
    var headers: Set<Header> { get }
}

protocol AnyClientFrame: AnyFrame, Encodable {
    
    var command: ClientCommand { get }
}

protocol AnyServerFrame: AnyFrame, Decodable {
    
    var command: ServerCommand { get }
}

protocol AnyPayloadFrame: AnyFrame {
    
    var body: String? { get }
}
