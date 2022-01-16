import Foundation
import RxSwift

protocol AppSettingsUseCase {
    func isValidRefreshTim(value: Int) -> Bool
    func settings() -> Observable<AppSettings>
    func udpate(settings: AppSettings) -> Single<Void>
}
