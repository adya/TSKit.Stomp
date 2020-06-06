import TSKit_Core

struct SubscribeFrame: AnyClientFrame {
    
    let command: ClientCommand = .subscribe
    
    let headers: Set<Header>
    
    init(destination: String,
         id: String,
         acknowledge: Stomp.Acknowledge? = nil,
         receipt: String? = nil,
         additionalHeaders: Set<Header>? = nil) {
        self.headers = transform([.destination(path: destination),
                                  .id(id)]) { headers in
            _ = acknowledge.flatMap { headers.insert(.ack($0)) }
            _ = receipt.flatMap { headers.insert(.receipt($0)) }
            (additionalHeaders?.subtracting(headers)).flatMap { headers.formUnion($0) }
        }
    }
}
