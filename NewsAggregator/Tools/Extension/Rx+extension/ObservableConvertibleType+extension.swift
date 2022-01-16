import Foundation
import RxSwift

extension ObservableConvertibleType {
    func mapToVoid() -> Observable<Void> {
        asObservable().map { _ in }
    }
    
    func mapToOptional() -> Observable<Element?> {
        asObservable().map(Element?.init(_:))
    }
}
