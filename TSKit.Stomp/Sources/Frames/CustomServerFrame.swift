import Foundation

struct CustomServerFrame: AnyServerFrame {
    
    let command: ServerCommand
    
    let headers: HeaderSet
    
    let body: String?
    
    init(command: String, headers: HeaderSet, body: String? = nil) {
        self.command = .custom(command.uppercased())
        self.headers = headers
        self.body = body
    }
}
