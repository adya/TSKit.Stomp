import TSKit_Core

struct UnsubscribeFrame: AnyClientFrame {
    
    let command: ClientCommand = .unsubscribe
    
    let headers: Set<Header>
    
    init(id: String,
         receipt: String? = nil,
         additionalHeaders: Set<Header>? = nil) {
        self.headers = transform([.id(id)]) { headers in
            _ = receipt.flatMap { headers.insert(.receipt($0)) }
            (additionalHeaders?.subtracting(headers)).flatMap { headers.formUnion($0) }
        }
    }
}
