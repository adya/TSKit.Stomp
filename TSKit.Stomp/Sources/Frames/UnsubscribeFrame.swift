import TSKit_Core

public struct UnsubscribeFrame: AnyClientFrame {
    
    public let command: ClientCommand = .unsubscribe
    
    public let headers: HeaderSet
    
    public init(id: String,
                receipt: String? = nil,
                additionalHeaders: HeaderSet? = nil) {
        self.headers = transform(HeaderSet()) { headers in
            headers.id = id
            headers.receipt = receipt
            additionalHeaders.flatMap { headers.formUnion($0) }
        }
    }
}
