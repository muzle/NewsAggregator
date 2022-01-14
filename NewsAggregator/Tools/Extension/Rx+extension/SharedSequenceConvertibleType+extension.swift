import Foundation
import RxSwift
import RxCocoa

extension SharedSequenceConvertibleType {
    func route<Rouer: RouterType>(
        with router: Rouer
    ) -> SharedSequence<SharingStrategy, Void>
        where Rouer.Event == Element {
        asSharedSequence().do(onNext: router.handle(event:)).map { _ in }
    }
}
