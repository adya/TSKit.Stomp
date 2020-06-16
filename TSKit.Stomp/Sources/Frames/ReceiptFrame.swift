public struct ReceiptFrame: AnyServerFrame {
    
    public let command: ServerCommand = .receipt
    
    /// Required:
    /// - receipt-id
    public let headers: HeaderSet
}
