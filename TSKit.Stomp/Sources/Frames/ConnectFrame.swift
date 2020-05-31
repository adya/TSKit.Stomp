struct ConnectFrame: AnyClientFrame {
    
    let command: ClientCommand = .connect
    
    let headers: Set<Header>
    
    init(acceptedVersion: [String] = StompVersion.supported,
         host: String) {
        self.headers = [.acceptVersion(acceptedVersion),
                        .host(host)]
    }
}
