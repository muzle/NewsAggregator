import Foundation

protocol RealmRepresentable {
    
    associatedtype RealmType: CommonRepresentable
    
    var uid: String { get }
    func asRealm() -> RealmType
}
