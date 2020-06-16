import TSKit_Core

public typealias AckFrame = AcknowledgeFrame

public struct AcknowledgeFrame: AnyClientFrame {
    
    public let command: ClientCommand = .ack
    
    public let headers: HeaderSet
    
    public init(id: String,
                transaction: String? = nil,
                receipt: String? = nil,
                additionalHeaders: HeaderSet? = nil) {
        self.headers = transform(HeaderSet()) { headers in
            headers.id = id
            headers.transaction = transaction
            headers.receipt = receipt
            additionalHeaders.flatMap { headers.formUnion($0) }
        }
    }
}
