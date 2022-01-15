import Foundation

internal protocol RealmRepresentable {
    associatedtype RealmType: CommonRepresentable
    
    func asRealm() -> RealmType
}
