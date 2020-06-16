import TSKit_Core

public struct CommitFrame: AnyClientFrame {
    
    public let command: ClientCommand = .commit
    
    public let headers: HeaderSet
    
    public init(transaction: String,
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
