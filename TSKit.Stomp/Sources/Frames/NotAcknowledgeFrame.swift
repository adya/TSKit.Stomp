import TSKit_Core

typealias NackFrame = NotAcknowledgeFrame

struct NotAcknowledgeFrame: AnyClientFrame {
    
    let command: ClientCommand = .nack
    
    let headers: Set<Header>
    
    init(id: String,
         transaction: String? = nil,
         receipt: String? = nil,
         additionalHeaders: Set<Header>? = nil) {
        self.headers = transform([.id(id)]) { headers in
            _ = transaction.flatMap { headers.insert(.transaction($0)) }
            _ = receipt.flatMap { headers.insert(.receipt($0)) }
            (additionalHeaders?.subtracting(headers)).flatMap { headers.formUnion($0) }
        }
    }
}
