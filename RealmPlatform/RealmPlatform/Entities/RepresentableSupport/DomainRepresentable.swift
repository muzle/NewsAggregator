import Foundation

internal protocol DomainRepresentable {
    associatedtype DomainType
    func asDomain() -> DomainType
}
