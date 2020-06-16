import TSKit_Core

public struct BeginFrame: AnyClientFrame {
    
    public let command: ClientCommand = .begin
    
    public let headers: HeaderSet
    
    public init(transaction: String,
                receipt: String? = nil,
                additionalHeaders: HeaderSet? = nil) {
        self.headers = transform(HeaderSet()) { headers in
            headers.transaction = transaction
            headers.receipt = receipt
            additionalHeaders.flatMap { headers.formUnion($0) }
        }
    }
}
