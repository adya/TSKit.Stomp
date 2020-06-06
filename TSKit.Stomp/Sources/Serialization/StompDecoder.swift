import Foundation

final class StompDecoder {
    
    func decode(_ string: RawFrame) throws -> AnyServerFrame {
        var components = string.components(separatedBy: "\n")
        guard !components.isEmpty else {
            throw StompDecodingError.unexpectedEndOfFrame
        }
        
        let command = try ServerCommand(rawValue: components.removeFirst())
        
        var headers: Set<Header> = []
        while !components.isEmpty, !components.first!.isEmpty {
            let header = try Header(rawValue: components.removeFirst())
            if !headers.contains(header) {
                headers.insert(header)
            }
        }
        
        let body = components.nonEmpty?.joined(separator: "\n")
        
        switch command {
            case .connected: return ConnectedFrame(headers: headers)
            case .error: return ErrorFrame(headers: headers)
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

extension Header {
    
    init(rawValue: String) throws {
        var components = rawValue.components(separatedBy: ":")
        guard components.count > 1 else {
            throw StompDecodingError.malformedHeader
        }
        
        let key = components.removeFirst()
        let value = components.joined(separator: "")
        
        if let stomp = Stomp.Header(rawValue: key) {
            switch stomp {
                case .contentLength:
                    guard let length = Int(value) else { throw StompDecodingError.malformedHeader }
                    self = .contentLength(length: length)
                case .contentType:
                    self = .contentType(type: value)
                case .receipt:
                    self = .receipt(value)
                case .acceptVersion:
                    self = .acceptVersion(value.components(separatedBy: ","))
                case .host:
                    self = .host(value)
                case .login:
                    self = .login(value)
                case .passcode:
                    self = .passcode(value)
                case .heartBeat:
                    let bits = value.components(separatedBy: ",").compactMap({ Int($0) })
                    guard bits.count == 2 else { throw StompDecodingError.malformedHeader }
                    self = .heartBeat(outgoingInterval: bits.first!, expectedInterval: bits.last!)
                case .version:
                    self = .version(version: value)
                case .id:
                    self = .id(value)
                case .session:
                    self = .session(value)
                case .server:
                    self = .server(value)
                case .destination:
                    self = .destination(path: value)
                case .transaction:
                    self = .transaction(value)
                case .ack:
                    guard let acknowledge = Stomp.Acknowledge(rawValue: value) else { throw StompDecodingError.malformedHeader }
                    self = .ack(acknowledge)
                case .subscription:
                    self = .subscription(subId: value)
                case .messageId:
                    self = .messageId(id: value)
                case .receiptId:
                    self = .receiptId(value)
                case .message:
                    self = .message(message: value)
            }
        } else {
            self = .custom(key: key, value: value)
        }
    }
}
