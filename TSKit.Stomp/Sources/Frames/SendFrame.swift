import TSKit_Core

public struct SendFrame: AnyClientFrame {
    
    public let command: ClientCommand = .send
    
    public let headers: HeaderSet
    
    public let body: String?
    
    private init(bodyOrNil body: String?,
                 destination: String,
                 contentLength: Int?,
                 contentType: String?,
                 transaction: String?,
                 receipt: String?,
                 additionalHeaders: HeaderSet?) {
        self.body = body
        self.headers = transform(HeaderSet()) { headers in
            if let body = body {
                headers.contentLength = (contentLength ?? body.octetCount + 1)
            }
            headers.destination = destination
            headers.contentType = contentType
            headers.receipt = receipt
            headers.transaction = transaction
            additionalHeaders.flatMap { headers.formUnion($0) }
        }
    }
    
    public init(body: String,
                destination: String,
                contentLength: Int? = nil,
                contentType: String? = nil,
                receipt: String? = nil,
                transaction: String? = nil,
                additionalHeaders: HeaderSet? = nil) {
        self.init(bodyOrNil: body,
                  destination: destination,
                  contentLength: contentLength,
                  contentType: contentType,
                  transaction: transaction,
                  receipt: receipt,
                  additionalHeaders: additionalHeaders)
    }
    
    public init(destination: String,
                receipt: String? = nil,
                transaction: String? = nil,
                additionalHeaders: HeaderSet? = nil) {
        self.init(bodyOrNil: nil,
                  destination: destination,
                  contentLength: nil,
                  contentType: nil,
                  transaction: transaction,
                  receipt: receipt,
                  additionalHeaders: additionalHeaders)
        
    }
}
