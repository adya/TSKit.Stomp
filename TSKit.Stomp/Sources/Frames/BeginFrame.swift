import TSKit_Core

struct BeginFrame: AnyClientFrame {
    
    let command: ClientCommand = .begin
    
    let headers: HeaderSet
    
    init(transaction: String,
         receipt: String? = nil,
         additionalHeaders: HeaderSet? = nil) {
        self.headers = transform(HeaderSet()) { headers in
            headers.transaction = transaction
            headers.receipt = receipt
            additionalHeaders.flatMap { headers.formUnion($0) }
        }
    }
}
