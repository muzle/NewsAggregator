import Foundation
import RxSwift
import Domain

protocol AppSettingsService {
    func isValidRefreshTim(value: Int) -> Bool
    func settingsModel() throws -> AppSettings
    func settings() -> Observable<AppSettings>
    func udpate(settings: AppSettings) -> Single<Void>
    func addTrackableResources(resources: [PostsResourceInfo]) throws
    func resetTrackableResources(resources: [PostsResourceInfo]) throws
}
