import Foundation

final class StompEncoder {
    
    func encode(_ frame: AnyClientFrame) -> RawFrame {
        var result = [String(describing: frame.command)]
        result += frame.headers.map(String.init(describing:)).sorted()
        
        if let frame = frame as? AnyPayloadFrame, let body = frame.body {
            result += ["", body]
        }
        
        return result.joined(separator: "\n")
    }
}
