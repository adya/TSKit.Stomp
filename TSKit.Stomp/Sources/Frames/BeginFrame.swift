import TSKit_Core

struct BeginFrame: AnyClientFrame {
    
    let command: ClientCommand = .begin
    
    let headers: Set<Header>
    
    init(transaction: String,
         receipt: String? = nil,
         additionalHeaders: Set<Header>? = nil) {
        self.headers = transform([.transaction(transaction)]) { headers in
            _ = receipt.flatMap { headers.insert(.receipt($0)) }
            (additionalHeaders?.subtracting(headers)).flatMap { headers.formUnion($0) }
        }
    }
}
