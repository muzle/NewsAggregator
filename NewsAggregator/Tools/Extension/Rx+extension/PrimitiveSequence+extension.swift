import Foundation
import RxSwift

extension PrimitiveSequence where Trait == SingleTrait {
    func mapToVoid() -> PrimitiveSequence<Trait, Void> {
        map { _ in }
    }
}
