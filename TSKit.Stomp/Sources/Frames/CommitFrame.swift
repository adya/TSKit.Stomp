import TSKit_Core

struct CommitFrame: AnyClientFrame {
    
    let command: ClientCommand = .commit
    
    let headers: HeaderSet
    
    init(transaction: String,
         receipt: String? = nil,
         additionalHeaders: HeaderSet? = nil) {
        
        self.headers = transform(HeaderSet()) { headers in
            headers.transaction = transaction
            headers.receipt = receipt
            additionalHeaders?.customHeaders.forEach {
                headers.set($0.1, forHeaderNamed: $0.0)
            }
        }
    }
}
