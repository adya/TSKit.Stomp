import TSKit_Core

struct DisconnectFrame: AnyClientFrame {
    
    let command: ClientCommand = .disconnect
    
    let headers: Set<Header>
    
    init(receipt: String? = nil,
         additionalHeaders: Set<Header>? = nil) {
        self.headers = transform([]) { headers in
            _ = receipt.flatMap { headers.insert(.receipt($0)) }
            (additionalHeaders?.subtracting(headers)).flatMap { headers.formUnion($0) }
        }
    }
}
