import Foundation

extension Sequence where Element: CommonRepresentable {
    func mapToCommon() -> [Element.CommonType] {
        map { $0.asCommon() }
    }
}

extension Sequence where Element: DomainRepresentable {
    func mapToDomain() -> [Element.DomainType] {
        map { $0.asDomain() }
    }
}
