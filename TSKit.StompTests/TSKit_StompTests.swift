import XCTest
@testable import TSKit_Stomp

class TSKit_StompTests: XCTestCase {

    func testClientCommandsAreSTOMPCompliant() {
        let commands: [(command: ClientCommand, expectation: String)] = [
            (.connect, "CONNECT"),
            (.stomp, "STOMP"),
            (.disconnect, "DISCONNECT"),
            (.send, "SEND"),
            (.subscribe, "SUBSCRIBE"),
            (.unsubscribe, "UNSUBSCRIBE"),
            (.begin, "BEGIN"),
            (.commit, "COMMIT"),
            (.abort, "ABORT"),
            (.ack, "ACK"),
            (.nack, "NACK"),
            (.custom("CusTom"), "CUSTOM")
        ]
        
        commands.forEach {
            XCTAssertEqual($0.command.fragment, $0.expectation)
        }
    }
    
    func testServerCommandsAreSTOMPCompliant() {
        let commands: [(command: ServerCommand, expectation: String)] = [
            (.connected, "CONNECTED"),
            (.message, "MESSAGE"),
            (.receipt, "RECEIPT"),
            (.error, "ERROR"),
            (.custom("CusTom"), "CUSTOM")
        ]
        
        commands.forEach {
            XCTAssertEqual($0.command.fragment, $0.expectation)
        }
    }
    
}
