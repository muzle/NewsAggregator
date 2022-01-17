import Foundation

extension String {
    var isDelite: Bool {
        guard
            let cChar = cString(using: String.Encoding.utf8),
            strcmp(cChar, "\\b") == -92
        else { return false }
        return true
    }
}
