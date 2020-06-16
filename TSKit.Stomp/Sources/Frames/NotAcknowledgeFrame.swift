import TSKit_Core

public typealias NackFrame = NotAcknowledgeFrame

public struct NotAcknowledgeFrame: AnyClientFrame {
    
    public let command: ClientCommand = .nack
    
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
