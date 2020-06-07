import Foundation
import TSKit_Core

public struct HeaderSet {
    
    public private(set) var headers: [Stomp.Header: String] = [:]
    
    public private(set) var customHeaders: [String: String] = [:]
    
    public var allHeaders: [String: String] {
        transform(headers.map(key: { $0.0.rawValue },
                              value: { $0.1 })) { headers in
            customHeaders.forEach { (key, value) in
                headers[key] = value
            }
        }
    }
    
    public init() {}
    
    public mutating func set(_ value: String, for header: Stomp.Header) {
        headers[header] = value
    }
    
    public mutating func remove(_ header: Stomp.Header) {
        headers.removeValue(forKey: header)
    }
    
    public func contains(_ header: Stomp.Header) -> Bool {
        headers[header] != nil
    }
}

// MARK: - Custom headers
public extension HeaderSet {
    
    func header(named name: String) -> String? {
        if let stompHeader = Stomp.Header(rawValue: name.lowercased()) {
            return headers[stompHeader]
        } else {
            return customHeaders[name]
        }
    }
    
    mutating func set(_ value: String, forHeaderNamed name: String) {
        if let stompHeader = Stomp.Header(rawValue: name.lowercased()) {
            set(value, for: stompHeader)
        } else {
            customHeaders[name] = value
        }
    }
    
    mutating func removeHeader(named name: String) {
        if let stompHeader = Stomp.Header(rawValue: name.lowercased()) {
            remove(stompHeader)
        } else {
            customHeaders.removeValue(forKey: name)
        }
    }
    
    func containsHeader(named name: String) -> Bool {
        if let stompHeader = Stomp.Header(rawValue: name.lowercased()) {
            return contains(stompHeader)
        } else {
            return customHeaders[name] != nil
        }
    }
}

// MARK: - Accessors
public extension HeaderSet {
    
    var contentLength: Int? {
        get { headers[.contentLength].flatMap(Int.init) }
        set { headers[.contentLength] = newValue.flatMap(String.init(describing:)) }
    }
    
    var contentType: String? {
        get { headers[.contentType] }
        set { headers[.contentType] = newValue }
    }
    
    var receipt: String? {
        get { headers[.receipt] }
        set { headers[.receipt] = newValue }
    }
    
    var acceptVersion: [String]? {
        get { headers[.acceptVersion]?.components(separatedBy: ",") }
        set { headers[.acceptVersion] = newValue?.map { $0.trimmingCharacters(in: .whitespaces) }.joined(separator: ",") }
    }
    
    var host: String? {
        get { headers[.host] }
        set { headers[.host] = newValue }
    }
    
    var login: String? {
        get { headers[.login] }
        set { headers[.login] = newValue }
    }
    
    var passcode: String? {
        get { headers[.passcode] }
        set { headers[.passcode] = newValue }
    }
    
    var heartBeat: HeartBeat? {
        get {
            headers[.heartBeat].flatMap { value in
                let beats = value.components(separatedBy: ",").compactMap({ UInt($0) })
                guard beats.count == 2 else { return nil }
                return .init(guaranteed: beats.first!, expected: beats.last!)
            }
        }
        set {
            headers[.heartBeat] = newValue.flatMap { "\($0.guaranteed),\($0.expected)" }
        }
    }
    
    var version: String? {
        get { headers[.version] }
        set { headers[.version] = newValue }
    }
    
    var id: String? {
        get { headers[.id] }
        set { headers[.id] = newValue }
    }
    
    var session: String? {
        get { headers[.session] }
        set { headers[.session] = newValue }
    }
    
    var server: String? {
        get { headers[.server] }
        set { headers[.server] = newValue }
    }
    
    var destination: String? {
        get { headers[.destination] }
        set { headers[.destination] = newValue }
    }
    
    var transaction: String? {
        get { headers[.transaction] }
        set { headers[.transaction] = newValue }
    }
    
    var acknowledge: Stomp.Acknowledge? {
        get { headers[.ack].flatMap(Stomp.Acknowledge.init(rawValue:)) }
        set { headers[.ack] = newValue?.rawValue }
    }
    
    var subscription: String? {
        get { headers[.subscription] }
        set { headers[.subscription] = newValue }
    }
    
    var messageId: String? {
        get { headers[.messageId] }
        set { headers[.messageId] = newValue }
    }
    
    var receiptId: String? {
        get { headers[.receiptId] }
        set { headers[.receiptId] = newValue }
    }
    
    var message: String? {
        get { headers[.message] }
        set { headers[.message] = newValue }
    }
}

public extension HeaderSet {
    
    mutating func formUnion(_ other: HeaderSet) {
        other.allHeaders.filter { !containsHeader(named: $0.key) }
                        .forEach { set($0.value, forHeaderNamed: $0.key) }
    }
}
