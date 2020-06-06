import TSKit_Core

struct ConnectFrame: AnyClientFrame {
    
    let command: ClientCommand = .connect
    
    let headers: HeaderSet
    
    init(acceptedVersion: [String] = Stomp.versions,
         host: String,
         heartBeat: HeartBeat? = nil,
         login: String? = nil,
         passcode: String? = nil) {
        self.headers = transform(HeaderSet()) { headers in
            headers.acceptVersion = acceptedVersion
            headers.host = host
            headers.login = login
            headers.passcode = passcode
            headers.heartBeat = heartBeat
        }
    }
}
