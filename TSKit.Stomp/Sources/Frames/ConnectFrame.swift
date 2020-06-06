struct ConnectFrame: AnyClientFrame {
    
    let command: ClientCommand = .connect
    
    let headers: Set<Header>
    
    init(acceptedVersion: [String] = Stomp.versions,
         host: String) {
        self.headers = [.acceptVersion(acceptedVersion),
                        .host(host)]
    }
}
