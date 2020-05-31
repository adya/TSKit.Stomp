import Foundation

extension String {
    
    /// Octet count for the length of the string.
    var octetCount: Int { utf8.count }
}
