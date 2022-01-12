import Foundation

public protocol Appliable { }

public extension Appliable {
    @discardableResult
    func apply(closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

// MARK: - NSObject implement Applicable

extension NSObject: Appliable { }
