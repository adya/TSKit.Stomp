protocol AnyFrame {
    
    var headers: Set<Header> { get }
    
    /// Encoded representation of the frame.
    var encoded: String { get }
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

extension AnyClientFrame {
    
    var encoded: String {
        """
        \(command.fragment)
        \(headers.fragment)
        """
    }
}

extension AnyPayloadFrame where Self: AnyClientFrame {
    
    var encoded: String {
        """
        \(command.fragment)
        \(headers.fragment)
        \(body.flatMap {"\n\($0)"} ?? "")
        """
    }
}

extension AnyPayloadFrame where Self: AnyServerFrame {
    
    var encoded: String {
        """
        \(command.fragment)
        \(headers.fragment)
        \(body.flatMap {"\n\($0)"} ?? "")
        """
    }
}
