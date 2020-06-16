import TSKit_Core

public struct SubscribeFrame: AnyClientFrame {
    
    public let command: ClientCommand = .subscribe
    
    public let headers: HeaderSet
    
    public init(destination: String,
                id: String,
                acknowledge: Stomp.Acknowledge? = nil,
                receipt: String? = nil,
                additionalHeaders: HeaderSet? = nil) {
        self.headers = transform(HeaderSet()) { headers in
            headers.destination = destination
            headers.id = id
            headers.acknowledge = acknowledge
            headers.receipt = receipt
            additionalHeaders.flatMap { headers.formUnion($0) }
        }
    }
}
