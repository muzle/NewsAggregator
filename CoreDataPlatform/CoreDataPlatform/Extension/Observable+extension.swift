import Foundation
import RxSwift

extension Observable where Element: Sequence, Element.Element: DomainConvertible {
    func mapToDomain() -> Observable<[Element.Element.DomainType]> {
        map { $0.mapToDomain() }
    }
}
