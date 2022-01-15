import Foundation

extension Sequence where Element: DomainConvertible {
    func mapToDomain() -> [Element.DomainType] {
        map { $0.asDomain() }
    }
}
