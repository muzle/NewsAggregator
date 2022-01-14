import Foundation

extension Sequence where Element: CommonRepresentable {
    func mapToCommon() -> [Element.CommonType] {
        map { $0.asCommon() }
    }
}
