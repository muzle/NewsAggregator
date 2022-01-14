import Foundation

internal protocol CommonRepresentable {
    associatedtype CommonType
    
    func asCommon() -> CommonType
    
    var uid: String { get }
    static func primaryKey() -> String
}

// MARK: - Default implementation

extension CommonRepresentable {
    static func primaryKey() -> String {
        "uid"
    }
}
