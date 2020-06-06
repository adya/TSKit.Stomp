import TSKit_Core

struct DisconnectFrame: AnyClientFrame {
    
    let command: ClientCommand = .disconnect
    
    let headers: HeaderSet
    
    init(receipt: String? = nil,
         additionalHeaders: HeaderSet? = nil) {
        self.headers = transform(HeaderSet()) { headers in
            headers.receipt = receipt
            additionalHeaders.flatMap { headers.formUnion($0) }
        }
    }
}
