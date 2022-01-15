import Foundation
import RxSwift

extension Observable where Element: Sequence, Element.Element: CommonRepresentable {
    typealias CommonType = Element.Element.CommonType
    
    func mapToCommon() -> Observable<[CommonType]> {
        map { $0.mapToCommon() }
    }
}

extension Observable where Element: Sequence, Element.Element: DomainRepresentable {
    func mapToDomain() -> Observable<[Element.Element.DomainType]> {
        map { $0.mapToDomain() }
    }
}
