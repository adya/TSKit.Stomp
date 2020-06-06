import TSKit_Core

struct UnsubscribeFrame: AnyClientFrame {
    
    let command: ClientCommand = .unsubscribe
    
    let headers: HeaderSet
    
    init(id: String,
         receipt: String? = nil,
         additionalHeaders: HeaderSet? = nil) {
        self.headers = transform(HeaderSet()) { headers in
            headers.id = id
            headers.receipt = receipt
            additionalHeaders.flatMap { headers.formUnion($0) }
        }
    }
}
