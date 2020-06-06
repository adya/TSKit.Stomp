import XCTest
@testable import TSKit_Stomp

class StompEncoderTests: XCTestCase {
    
    private var encoder: StompEncoder!
    
    private let builder = StompFrameBuilder()
    
    override func setUp() {
        encoder = .init()
    }
    
    override func tearDown() {
        builder.reset()
    }
}

// MARK: - Frames
extension StompEncoderTests {
    
    func testConnectFrameEncoding() {
        let raw = encoder.encode(ConnectFrame(acceptedVersion: ["1.1", "1.2"],
                                              host: "somewhere",
                                              heartBeat: .init(guaranteed: 10, expected: 20),
                                              login: "mylogin",
                                              passcode: "securepass"))
        
        XCTAssertEqual(raw, builder.command(.connect)
                                   .header(.acceptVersion, value: "1.1,1.2")
                                   .header(.heartBeat, value: "10,20")
                                   .header(.host, value: "somewhere")
                                   .header(.login, value: "mylogin")
                                   .header(.passcode, value: "securepass")
                                   .make())
    }
    
    func testDisonnectFrameEncoding() {
        let raw = encoder.encode(DisconnectFrame(receipt: "1",
                                                 additionalHeaders: [.custom(key: "custom", value: "yes")]))
        XCTAssertEqual(raw, builder.command(.disconnect)
                                   .header(.receipt, value: "1")
                                   .customHeader(key: "custom", value: "yes")
                                   .make())
    }
    
    func testSendFrameEncoding() {
        let message = "Some meaningful message"
        let raw = encoder.encode(SendFrame(body: message,
                                           destination: "to server",
                                           contentLength: nil,
                                           contentType: "text/plain",
                                           receipt: "1",
                                           transaction: "2",
                                           additionalHeaders: [.custom(key: "custom", value: "yes")]))
        
        
        XCTAssertEqual(raw, builder.command(.send)
                                   .header(.contentLength, value: "\(message.octetCount)")
                                   .header(.contentType, value: "text/plain")
                                   .header(.destination, value: "to server")
                                   .header(.receipt, value: "1")
                                   .header(.transaction, value: "2")
                                   .customHeader(key: "custom", value: "yes")
                                   .message(message)
                                   .make())
    }
    
    func testSubscribeFrameEncoding() {
        let raw = encoder.encode(SubscribeFrame(destination: "to server",
                                                id: "2",
                                                acknowledge: .clientIndividual,
                                                receipt: "1",
                                                additionalHeaders: [.custom(key: "custom", value: "yes")]))
        
        XCTAssertEqual(raw, builder.command(.subscribe)
                                   .header(.ack, value: Stomp.Acknowledge.clientIndividual.rawValue)
                                   .header(.destination, value: "to server")
                                   .header(.id, value: "2")
                                   .header(.receipt, value: "1")
                                   .customHeader(key: "custom", value: "yes")
                                   .make())
    }
    
    func testUnsubscribeFrameEncoding() {
        let raw = encoder.encode(UnsubscribeFrame(id: "2",
                                                  receipt: "1",
                                                  additionalHeaders: [.custom(key: "custom", value: "yes")]))
        
        XCTAssertEqual(raw, builder.command(.unsubscribe)
                                   .header(.id, value: "2")
                                   .header(.receipt, value: "1")
                                   .customHeader(key: "custom", value: "yes")
                                   .make())
    }
    
    func testAcknowledgeFrameEncoding() {
        let raw = encoder.encode(AcknowledgeFrame(id: "3",
                                                  transaction: "2",
                                                  receipt: "1",
                                                  additionalHeaders: [.custom(key: "custom", value: "yes")]))
        XCTAssertEqual(raw, builder.command(.ack)
                                   .header(.id, value: "3")
                                   .header(.receipt, value: "1")
                                   .header(.transaction, value: "2")
                                   .customHeader(key: "custom", value: "yes")
                                   .make())
    }
    
    func testNotAcknowledgeFrameEncoding() {
        let raw = encoder.encode(NotAcknowledgeFrame(id: "3",
                                                  transaction: "2",
                                                  receipt: "1",
                                                  additionalHeaders: [.custom(key: "custom", value: "yes")]))
        XCTAssertEqual(raw, builder.command(.nack)
                                   .header(.id, value: "3")
                                   .header(.receipt, value: "1")
                                   .header(.transaction, value: "2")
                                   .customHeader(key: "custom", value: "yes")
                                   .make())
    }
    
    func testBeginFrameEncoding() {
        let raw = encoder.encode(BeginFrame(transaction: "2",
                                            receipt: "1",
                                            additionalHeaders: [.custom(key: "custom", value: "yes")]))
        XCTAssertEqual(raw, builder.command(.begin)
                                   .header(.receipt, value: "1")
                                   .header(.transaction, value: "2")
                                   .customHeader(key: "custom", value: "yes")
                                   .make())
    }
    
    func testCommitFrameEncoding() {
        let raw = encoder.encode(CommitFrame(transaction: "2",
                                            receipt: "1",
                                            additionalHeaders: [.custom(key: "custom", value: "yes")]))
        XCTAssertEqual(raw, builder.command(.commit)
                                   .header(.receipt, value: "1")
                                   .header(.transaction, value: "2")
                                   .customHeader(key: "custom", value: "yes")
                                   .make())
    }
    
    func testAbortFrameEncoding() {
        let raw = encoder.encode(AbortFrame(transaction: "2",
                                            receipt: "1",
                                            additionalHeaders: [.custom(key: "custom", value: "yes")]))
        XCTAssertEqual(raw, builder.command(.abort)
                                   .header(.receipt, value: "1")
                                   .header(.transaction, value: "2")
                                   .customHeader(key: "custom", value: "yes")
                                   .make())
    }
}
