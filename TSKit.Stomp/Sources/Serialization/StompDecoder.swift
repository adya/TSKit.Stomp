import Foundation

final class StompDecoder {
    
    func decode(_ string: RawFrame) throws -> AnyServerFrame {
        var components = string.components(separatedBy: "\n")
        guard !components.isEmpty else {
            throw StompDecodingError.unexpectedEndOfFrame
        }
        
        let command = try ServerCommand(rawValue: components.removeFirst().lowercased())
        
        var headers = HeaderSet()
        while !components.isEmpty, !components.first!.isEmpty {
            guard let rawHeader = RawHeader(rawValue: components.removeFirst()) else {
                throw StompDecodingError.malformedHeader
            }
            
            if let header = Stomp.Header(rawValue: rawHeader.name) {
                if !headers.contains(header) {
                    headers.set(rawHeader.value, for: header)
                }
            } else {
                headers.set(rawHeader.value, forHeaderNamed: rawHeader.name)
            }
            
        }
        if !components.isEmpty {
            // If there is more components that means there will be message which must be separated with blank line
            components.removeFirst()
        }
        let body = components.nonEmpty?.joined(separator: "\n")
        
        switch command {
            case .connected: return ConnectedFrame(headers: headers)
            case .error: return ErrorFrame(headers: headers, body: body)
            case .receipt: return ReceiptFrame(headers: headers)
            case .message: return MessageFrame(headers: headers, body: body)
            case .custom(let command): return CustomServerFrame(command: command, headers: headers, body: body)
        }
    }
}

enum StompDecodingError: Error {
    
    case unexpectedEndOfFrame
    
    case malformedHeader
}

extension ServerCommand {
    
    init(rawValue: String) throws {
        
        if let stomp = Stomp.ServerCommand(rawValue: rawValue.lowercased()) {
            switch stomp {
                case .connected: self = .connected
                case .message: self = .message
                case .receipt: self = .receipt
                case .error: self = .error
            }
        } else {
            self = .custom(rawValue)
        }
    }
}
