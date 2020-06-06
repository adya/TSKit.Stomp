import TSKit_Core

struct ConnectFrame: AnyClientFrame {
    
    let command: ClientCommand = .connect
    
    let headers: Set<Header>
    
    init(acceptedVersion: [String] = Stomp.versions,
         host: String,
         heartBeat: HeartBeat? = nil,
         login: String? = nil,
         passcode: String? = nil) {
        self.headers = transform([.acceptVersion(acceptedVersion),
                                  .host(host)]) { headers in
            _ = login.flatMap { headers.insert(.login($0)) }
            _ = passcode.flatMap { headers.insert(.passcode($0)) }
            _ = heartBeat.flatMap { headers.insert(.heartBeat($0)) }
        }
    }
}
