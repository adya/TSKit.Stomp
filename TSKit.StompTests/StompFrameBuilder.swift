import Foundation
import TSKit_Core
@testable import TSKit_Stomp

final class StompFrameBuilder {
    
    fileprivate var command: String!
    
    fileprivate var headers: Set<Header> = []
    
    fileprivate var message: String?
    
    fileprivate var contentBuilder: StompContentBuilder!
    
    func command(_ command: Stomp.ClientCommand) -> StompContentBuilder {
        self.command = String(describing: command)
        contentBuilder = contentBuilder ?? .init(frameBuilder: self)
        return contentBuilder
    }
    
    func command(_ command: Stomp.ServerCommand) -> StompContentBuilder {
        self.command = String(describing: command)
        contentBuilder = contentBuilder ?? .init(frameBuilder: self)
        return contentBuilder
    }
    
    func reset() {
        command = nil
        headers.removeAll()
        message = nil
    }
    
    fileprivate struct Header: Hashable {
        
        let key: String
        
        let value: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(key)
        }
    }
}

final class StompContentBuilder {
    
    unowned let frameBuilder: StompFrameBuilder
    
    fileprivate init(frameBuilder: StompFrameBuilder) {
        self.frameBuilder = frameBuilder
    }
    
    func header(_ header: Stomp.Header, value: String) -> StompContentBuilder {
        frameBuilder.headers.insert(.init(key: header.rawValue, value: value))
        return self
    }
    
    func customHeader(key: String, value: String) -> StompContentBuilder {
        frameBuilder.headers.insert(.init(key: key, value: value))
        return self
    }
    
    func message(_ message: String? = nil) -> StompContentBuilder {
        frameBuilder.message = message
        return self
    }
    
    func make() -> RawFrame {
        transform([frameBuilder.command]) {
            $0 += frameBuilder.headers.map { "\($0.key):\($0.value)" }.sorted()
            if let message = frameBuilder.message {
                $0 += ["", message]
            }
        }.joined(separator: "\n")
    }
}
