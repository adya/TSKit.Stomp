import TSKit_Core

struct SendFrame: AnyClientFrame, AnyPayloadFrame {
   
    let command: ClientCommand = .send
    
    let headers: Set<Header>
    
    let body: String?
    
    private init(bodyOrNil body: String?,
                 destination: String,
                 contentLength: Int?,
                 contentType: String?,
                 transaction: String?,
                 receipt: String?,
                 additionalHeaders: Set<Header>?) {
        self.body = body
        self.headers = transform([.destination(path: destination)]) { headers in
            if let body = body {
                _ = headers.insert(.contentLength(length: contentLength ?? body.octetCount))
            }
            _ = receipt.flatMap { headers.insert(.receipt($0)) }
            _ = transaction.flatMap { headers.insert(.transaction($0)) }
            (additionalHeaders?.subtracting(headers)).flatMap { headers.formUnion($0) }
        }
    }
    
    init(body: String,
         destination: String,
         contentLength: Int? = nil,
         contentType: String? = nil,
         receipt: String? = nil,
         transaction: String? = nil,
         additionalHeaders: Set<Header>? = nil) {
        self.init(bodyOrNil: body,
                  destination: destination,
                  contentLength: contentLength,
                  contentType: contentType,
                  transaction: transaction,
                  receipt: receipt,
                  additionalHeaders: additionalHeaders)
    }
    
    init(destination: String,
         receipt: String? = nil,
         transaction: String? = nil,
         additionalHeaders: Set<Header>? = nil) {
        self.init(bodyOrNil: nil,
                  destination: destination,
                  contentLength: nil,
                  contentType: nil,
                  transaction: transaction,
                  receipt: receipt,
                  additionalHeaders: additionalHeaders)
        
    }
}
