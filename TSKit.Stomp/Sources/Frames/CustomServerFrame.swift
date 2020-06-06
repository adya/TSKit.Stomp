import Foundation

struct CustomServerFrame: AnyServerFrame, AnyPayloadFrame {
    
    let command: ServerCommand
    
    let headers: Set<Header>
    
    let body: String?
    
    init(command: String, headers: Set<Header>, body: String? = nil) {
        self.command = .custom(command.uppercased())
        self.headers = headers
        self.body = body
    }
}
