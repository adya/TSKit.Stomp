import TSKit_Core

public struct DisconnectFrame: AnyClientFrame {
    
    public let command: ClientCommand = .disconnect
    
    public let headers: HeaderSet
    
    public init(receipt: String? = nil,
         additionalHeaders: HeaderSet? = nil) {
        self.headers = transform(HeaderSet()) { headers in
            headers.receipt = receipt
            additionalHeaders.flatMap { headers.formUnion($0) }
        }
    }
}
