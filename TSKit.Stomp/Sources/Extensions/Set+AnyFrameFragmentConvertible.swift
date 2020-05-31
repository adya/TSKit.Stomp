import Foundation

extension Set: AnyFrameFragmentConvertible where Element: AnyFrameFragmentConvertible {
   
    var fragment: String {
        self.map { $0.fragment }
            .joined(separator: "\n")
    }
}
