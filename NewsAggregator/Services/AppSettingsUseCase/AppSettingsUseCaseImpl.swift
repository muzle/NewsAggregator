import Foundation
import RxSwift

final class AppSettingsUseCaseImpl: AppSettingsUseCase {
    private let storage: SingleObjectStorage<AppSettings>
    
    init(storage: SingleObjectStorage<AppSettings>) {
        self.storage = storage
        
        do {
            if try storage.data() == nil {
                _ = try storage.update(data: .makeDefault())
            }
        } catch {
            
        }
    }
    
    func isValidRefreshTim(value: Int) -> Bool {
        value > 0
    }
    
    func settings() -> Observable<AppSettings> {
        storage.rx.data()
            .map { model in
                guard let model = model else { throw AppSettingsUseCaseError.emptyData }
                return model
            }
    }
    
    func udpate(settings: AppSettings) -> Single<Void> {
        guard isValidRefreshTim(value: settings.refreshTimeInternalMin) else { return .error(AppSettingsUseCaseError.invalidRefreshTimeInterval) }
        return storage.rx.update(data: settings)
            .mapToVoid()
    }
    
    private enum AppSettingsUseCaseError: Error {
        case emptyData
        case invalidRefreshTimeInterval
    }
}
