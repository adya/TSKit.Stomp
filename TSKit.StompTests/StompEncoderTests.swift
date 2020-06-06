import XCTest
@testable import TSKit_Stomp

class StompEncoderTests: XCTestCase {
    
    private var encoder: StompEncoder!
    
    override func setUp() {
        encoder = .init()
    }
}

// MARK: - Frames
extension StompEncoderTests {
    
    func testConnectFrameEncoding() {
        let raw = encoder.encode(ConnectFrame(acceptedVersion: ["1.1", "1.2"], host: "somewhere"))
        XCTAssertEqual(raw, ["CONNECT",
                            "accept-version:1.1,1.2",
                            "host:somewhere"].joined(separator: "\n"))
    }
    
    func testDisonnectFrameEncoding() {
        let raw = encoder.encode(DisconnectFrame(receipt: "1",
                                                 additionalHeaders: [.custom(key: "custom", value: "yes")]))
        XCTAssertEqual(raw, ["DISCONNECT",
                             "custom:yes",
                             "receipt:1"].joined(separator: "\n"))
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
        XCTAssertEqual(raw, ["SEND",
                             "content-length:\(message.octetCount)",
                             "content-type:text/plain",
                             "custom:yes",
                             "destination:to server",
                             "receipt:1",
                             "transaction:2",
                             "",
                             message].joined(separator: "\n"))
    }
    
    func testSubscribeFrameEncoding() {
        let raw = encoder.encode(SubscribeFrame(destination: "to server",
                                                id: "2",
                                                acknowledge: .clientIndividual,
                                                receipt: "1",
                                                additionalHeaders: [.custom(key: "custom", value: "yes")]))
        XCTAssertEqual(raw, ["SUBSCRIBE",
                             "ack:client-individual",
                             "custom:yes",
                             "destination:to server",
                             "id:2",
                             "receipt:1"].joined(separator: "\n"))
    }
    
    func testUnsubscribeFrameEncoding() {
        let raw = encoder.encode(UnsubscribeFrame(id: "2",
                                                  receipt: "1",
                                                  additionalHeaders: [.custom(key: "custom", value: "yes")]))
        XCTAssertEqual(raw, ["UNSUBSCRIBE",
                             "custom:yes",
                             "id:2",
                             "receipt:1"].joined(separator: "\n"))
    }
    
    func testAcknowledgeFrameEncoding() {
        let raw = encoder.encode(AcknowledgeFrame(id: "3",
                                                  transaction: "2",
                                                  receipt: "1",
                                                  additionalHeaders: [.custom(key: "custom", value: "yes")]))
        XCTAssertEqual(raw, ["ACK",
                             "custom:yes",
                             "id:3",
                             "receipt:1",
                             "transaction:2"].joined(separator: "\n"))
    }
    
    func testNotAcknowledgeFrameEncoding() {
        let raw = encoder.encode(NotAcknowledgeFrame(id: "3",
                                                  transaction: "2",
                                                  receipt: "1",
                                                  additionalHeaders: [.custom(key: "custom", value: "yes")]))
        XCTAssertEqual(raw, ["NACK",
                             "custom:yes",
                             "id:3",
                             "receipt:1",
                             "transaction:2"].joined(separator: "\n"))
    }
    
    func testBeginFrameEncoding() {
        let raw = encoder.encode(BeginFrame(transaction: "2",
                                            receipt: "1",
                                            additionalHeaders: [.custom(key: "custom", value: "yes")]))
        XCTAssertEqual(raw, ["BEGIN",
                             "custom:yes",
                             "receipt:1",
                             "transaction:2"].joined(separator: "\n"))
    }
    
    func testCommitFrameEncoding() {
        let raw = encoder.encode(CommitFrame(transaction: "2",
                                            receipt: "1",
                                            additionalHeaders: [.custom(key: "custom", value: "yes")]))
        XCTAssertEqual(raw, ["COMMIT",
                             "custom:yes",
                             "receipt:1",
                             "transaction:2"].joined(separator: "\n"))
    }
    
    func testAbortFrameEncoding() {
        let raw = encoder.encode(AbortFrame(transaction: "2",
                                            receipt: "1",
                                            additionalHeaders: [.custom(key: "custom", value: "yes")]))
        XCTAssertEqual(raw, ["ABORT",
                             "custom:yes",
                             "receipt:1",
                             "transaction:2"].joined(separator: "\n"))
    }
}
