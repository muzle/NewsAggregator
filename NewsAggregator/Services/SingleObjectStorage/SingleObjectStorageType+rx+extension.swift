import Foundation
import RxSwift

public extension Reactive where Base: SingleObjectStorageType {
    func data() -> Observable<Base.DataType?> {
        Observable.deferred {
            Observable.create { [base] observer in
                base.addDataObserver { [observer] value in
                    observer.on(.next(value))
                }
                return Disposables.create()
            }
        }
    }
    
    func update(data: Base.DataType) -> Single<Base.DataType> {
        Single.create { [base] (observer) in
            do {
                let data = try base.update(data: data)
                observer(.success(data))
            } catch {
                observer(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    func clear() -> Single<Void> {
        Single.create { [base] observer in
            base.clear()
            observer(.success(()))
            return Disposables.create()
        }
    }
}
