import RxSwift

// https://github.com/sergdort/CleanArchitectureRxSwift/blob/master/CleanArchitectureRxSwift/Utility/ErrorTracker.swift

public final class ErrorTracker {
    private let _errors: PublishSubject<Error>
    
    public init() {
        self._errors = .init()
    }
    
    public func track<O: ObservableConvertibleType>(_ source: O) -> Observable<O.Element> {
        return source.asObservable().do(onError: on(error:))
    }
    
    public func on(error: Error) {
        #if DEBUG
        // swiftlint:disable dont_use_print
        print("ErrorTracker: ", error.localizedDescription)
        // swiftlint:enable dont_use_print
        #endif
        _errors.on(.next(error))
    }
    
    deinit {
        _errors.on(.completed)
    }
}

public extension ObservableConvertibleType {
    func trackError(_ tracker: ErrorTracker) -> Observable<Element> {
        return tracker.track(self)
    }
}

#if canImport(RxCocoa)
import RxCocoa

extension ErrorTracker: SharedSequenceConvertibleType {
    public typealias Element = Error
    public typealias SharingStrategy = SignalSharingStrategy
    public func asSharedSequence() -> SharedSequence<SharingStrategy, Error> {
        return _errors.asSignal(onErrorSignalWith: .empty())
    }
}

public extension ObservableConvertibleType {
    func trackToSignal(_ tracker: ErrorTracker) -> Signal<Element> {
        return tracker.track(self).asSignal(onErrorSignalWith: .empty())
    }
    
    func trackToDriver(_ tracker: ErrorTracker) -> Driver<Element> {
        return tracker.track(self).asDriver(onErrorDriveWith: .empty())
    }
}
#endif
