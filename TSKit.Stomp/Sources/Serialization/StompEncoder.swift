import Foundation

final class StompEncoder {
    
    func encode(_ frame: AnyClientFrame) -> RawFrame {
        var result = [String(describing: frame.command)]
        result += frame.headers.allHeaders.map(RawHeader.init)
                                          .map { $0.raw }
                                          .sorted()
        
        if let body = frame.body {
            result += ["", body]
        }
        
        return result.joined(separator: "\n")
    }
}
