struct ReceiptFrame: AnyServerFrame {
    
    let command: ServerCommand = .receipt
    
    /// Required:
    /// - receipt-id
    let headers: HeaderSet
}
