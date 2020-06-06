import XCTest
@testable import TSKit_Stomp

class StompDeccoderTests: XCTestCase {
    
    private var decoder: StompDecoder!
    
    private let builder = StompFrameBuilder()
    
    override func setUp() {
        decoder = .init()
    }
    
    override func tearDown() {
        builder.reset()
    }
}

// MARK: - Frames
extension StompDeccoderTests {
    
    func testConnectedFrameDecoding() {
        let raw = builder.command(.connected)
                         .header(.version, value: "1.2")
                         .header(.server, value: "me")
                         .header(.heartBeat, value: "100,200")
                         .header(.session, value: "22")
                         .make()
        
        var frame: AnyServerFrame!
        XCTAssertNoThrow(frame = try decoder.decode(raw))
        XCTAssertTrue(frame is ConnectedFrame)
        XCTAssertEqual(frame.headers.version, "1.2")
        XCTAssertEqual(frame.headers.server, "me")
        XCTAssertEqual(frame.headers.heartBeat, HeartBeat(guaranteed: 100, expected: 200))
        XCTAssertEqual(frame.headers.session, "22")
    }
    
    func testReceiptFrameDecoding() {
        let raw = builder.command(.receipt)
                         .header(.receiptId, value: "1")
                         .make()
        
        var frame: AnyServerFrame!
        XCTAssertNoThrow(frame = try decoder.decode(raw))
        XCTAssertTrue(frame is ReceiptFrame)
        XCTAssertEqual(frame.headers.receiptId, "1")
    }
    
    func testMessageFrameDecoding() {
        let message = "Some message"
        let raw = builder.command(.message)
                         .header(.subscription, value: "0")
                         .header(.destination, value: "2")
                         .header(.messageId, value: "3")
                         .header(.ack, value: Stomp.Acknowledge.clientIndividual.rawValue)
                         .header(.contentLength, value: "\(message.octetCount)")
                         .header(.contentType, value: "text/plain")
                         .message(message)
                         .make()
        
        var frame: AnyServerFrame!
        XCTAssertNoThrow(frame = try decoder.decode(raw))
        XCTAssertTrue(frame is MessageFrame)
        guard let payload = frame as? AnyPayloadFrame else { return }
        XCTAssertEqual(frame.headers.subscription, "0")
        XCTAssertEqual(frame.headers.destination, "2")
        XCTAssertEqual(frame.headers.messageId, "3")
        XCTAssertEqual(frame.headers.acknowledge, Stomp.Acknowledge.clientIndividual)
        XCTAssertEqual(frame.headers.contentLength, message.octetCount)
        XCTAssertEqual(frame.headers.contentType, "text/plain")
        XCTAssertEqual(payload.body, message)
    }
    
    func testErrorFrameDecoding() {
        let details = "Server won't help you"
        let raw = builder.command(.error)
                         .header(.receiptId, value: "2")
                         .header(.message, value: "Something wrong")
                         .header(.contentLength, value: "\(details.octetCount)")
                         .header(.contentType, value: "text/plain")
                         .message(details)
                         .make()
        var frame: AnyServerFrame!
        XCTAssertNoThrow(frame = try decoder.decode(raw))
        XCTAssertTrue(frame is ErrorFrame)
        guard let payload = frame as? AnyPayloadFrame else { return }
        XCTAssertEqual(frame.headers.message, "Something wrong")
        XCTAssertEqual(frame.headers.receiptId, "2")
        XCTAssertEqual(frame.headers.contentLength, details.octetCount)
        XCTAssertEqual(frame.headers.contentType, "text/plain")
        XCTAssertEqual(payload.body, details)
    }
}
