struct RawHeader {
    
    let name: String
    
    let value: String
    
    init(header: Stomp.Header, value: String) {
        self.name = header.rawValue
        self.value = value
    }
    
    init(header: String, value: String) {
        self.name = header
        self.value = value
    }
    
    init?(rawValue: String) {
        let components = rawValue.components(separatedBy: ":")
        guard components.count == 2 else { return nil }
        self.name = components.first!
        self.value = components.last!
    }
    
    var raw: String {
        "\(name):\(value)"
    }
}
