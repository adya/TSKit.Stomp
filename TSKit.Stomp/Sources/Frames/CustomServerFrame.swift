import Foundation

public struct CustomServerFrame: AnyServerFrame {
    
    public let command: ServerCommand
    
    public let headers: HeaderSet
    
    public let body: String?
    
    init(command: String, headers: HeaderSet, body: String? = nil) {
        self.command = .custom(command)
        self.headers = headers
        self.body = body
    }
}
