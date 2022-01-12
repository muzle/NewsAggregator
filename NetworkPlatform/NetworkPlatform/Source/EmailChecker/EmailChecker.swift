import Foundation

internal protocol EmailChecker {
    func isEmail(_ text: String) -> Bool
}
