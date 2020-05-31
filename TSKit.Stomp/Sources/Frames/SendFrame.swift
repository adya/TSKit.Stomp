struct SendFrame: AnyClientFrame, AnyPayloadFrame {
   
    let command: ClientCommand = .send
    
    let headers: Set<Header>
    
    let body: String?
    
    private init(bodyOrNil body: String?,
                 destination: String,
                 contentLength: Int?,
                 contentType: String?,
                 receipt: String?,
                 transaction: String?,
                 additionalHeaders: Set<Header>?) {
        self.body = body
        var headers: Set<Header> = [.destination(path: destination)]
        if let body = body {
            _ = headers.insert(.contentLength(length: contentLength ?? body.octetCount))
        }
        _ = receipt.flatMap { headers.insert(.receipt($0)) }
        _ = transaction.flatMap { headers.insert(.transaction($0)) }
        (additionalHeaders?.subtracting(headers)).flatMap { headers.formUnion($0) }
        self.headers = headers
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
                  receipt: receipt,
                  transaction: transaction,
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
                  receipt: receipt,
                  transaction: transaction,
                  additionalHeaders: additionalHeaders)
        
    }
}
