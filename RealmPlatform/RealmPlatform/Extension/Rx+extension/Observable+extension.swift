import Foundation
import RxSwift

extension Observable where Element: Sequence, Element.Element: CommonRepresentable {
    typealias CommonType = Element.Element.CommonType
    
    func mapToCommon() -> Observable<[CommonType]> {
        map { $0.mapToCommon() }
    }
}
