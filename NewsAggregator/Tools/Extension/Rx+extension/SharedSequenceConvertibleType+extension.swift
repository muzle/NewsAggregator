import Foundation
import RxSwift
import RxCocoa
import Domain

extension SharedSequenceConvertibleType {
    func route<Rouer: RouterType>(
        with router: Rouer
    ) -> SharedSequence<SharingStrategy, Void>
        where Rouer.Event == Element {
        asSharedSequence().do(onNext: router.handle(event:)).map { _ in }
    }
    
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        asSharedSequence().map { _ in }
    }
}

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {
    func flatMap<R>(
        _ selector: @escaping (Element) throws -> Single<R>,
        errorTracker: ErrorTracker
    ) -> Driver<R> {
        flatMap {
            do {
                return try selector($0).trackToDriver(errorTracker)
            } catch {
                errorTracker.on(error: error)
                return .never()
            }
        }
    }
    
    func flatMap<R>(
        _ selector: @escaping (Element) throws -> Single<R>,
        activitiIndicator: ActivityIndicator,
        errorTracker: ErrorTracker
    ) -> Driver<R> {
        flatMap {
            do {
                return try selector($0)
                    .trackActivity(activitiIndicator)
                    .trackToDriver(errorTracker)
            } catch {
                errorTracker.on(error: error)
                return .never()
            }
        }
    }
    
    func flatMap<R>(
        _ selector: @escaping (Element) throws -> Observable<R>,
        errorTracker: ErrorTracker
    ) -> Driver<R> {
        flatMap {
            do {
                return try selector($0).trackToDriver(errorTracker)
            } catch {
                errorTracker.on(error: error)
                return .never()
            }
        }
    }
    
    func flatMap<R>(
        _ selector: @escaping (Element) throws -> Observable<R>,
        activitiIndicator: ActivityIndicator,
        errorTracker: ErrorTracker
    ) -> Driver<R> {
        flatMap {
            do {
                return try selector($0)
                    .trackActivity(activitiIndicator)
                    .trackToDriver(errorTracker)
            } catch {
                errorTracker.on(error: error)
                return .never()
            }
        }
    }
}

extension SharedSequenceConvertibleType where SharingStrategy == SignalSharingStrategy {
    func flatMap<R>(
        _ selector: @escaping (Element) throws -> Single<R>,
        errorTracker: ErrorTracker
    ) -> Signal<R> {
        flatMap {
            do {
                return try selector($0).trackToSignal(errorTracker)
            } catch {
                errorTracker.on(error: error)
                return .never()
            }
        }
    }
    
    func flatMap<R>(
        _ selector: @escaping (Element) throws -> Single<R>,
        activitiIndicator: ActivityIndicator,
        errorTracker: ErrorTracker
    ) -> Signal<R> {
        flatMap {
            do {
                return try selector($0)
                    .trackActivity(activitiIndicator)
                    .trackToSignal(errorTracker)
            } catch {
                errorTracker.on(error: error)
                return .never()
            }
        }
    }
    
    func flatMap<R>(
        _ selector: @escaping (Element) throws -> Observable<R>,
        errorTracker: ErrorTracker
    ) -> Signal<R> {
        flatMap {
            do {
                return try selector($0).trackToSignal(errorTracker)
            } catch {
                errorTracker.on(error: error)
                return .never()
            }
        }
    }
    
    func flatMap<R>(
        _ selector: @escaping (Element) throws -> Observable<R>,
        activitiIndicator: ActivityIndicator,
        errorTracker: ErrorTracker
    ) -> Signal<R> {
        flatMap {
            do {
                return try selector($0)
                    .trackActivity(activitiIndicator)
                    .trackToSignal(errorTracker)
            } catch {
                errorTracker.on(error: error)
                return .never()
            }
        }
    }
}
