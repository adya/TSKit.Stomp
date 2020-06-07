import TSKit_Core

public struct ConnectFrame: AnyClientFrame {
    
    public let command: ClientCommand = .connect
    
    public let headers: HeaderSet
    
    public init(acceptedVersion: [String] = Stomp.versions,
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
