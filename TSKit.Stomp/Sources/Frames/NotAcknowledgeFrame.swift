import TSKit_Core

typealias NackFrame = NotAcknowledgeFrame

struct NotAcknowledgeFrame: AnyClientFrame {
    
    let command: ClientCommand = .nack
    
    let headers: HeaderSet
    
    init(id: String,
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
