import Foundation
import RxSwift
import Domain

final class AppSettingsServiceImpl: AppSettingsService {
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
    
    func settingsModel() throws -> AppSettings {
        guard let model = try storage.data() else {
            return try storage.update(data: .makeDefault())
        }
        return model
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
    
    func addTrackableResources(resources: [PostsResourceInfo]) throws {
        let model = try storage.data() ?? .makeDefault()
        var resourcesTrackingStates = model.resourcesTrackingStates
        for resource in resources {
            guard resourcesTrackingStates.contains(where: { $0.resource.id != resource.id }) else { continue }
            let new = ResourceTrackingState(
                resource: resource,
                isTacked: true
            )
            resourcesTrackingStates.append(new)
        }
        let newModel = model.byAdding(.resourcesTrackingStates(resourcesTrackingStates))
        _ = try storage.update(data: newModel)
    }
    
    func resetTrackableResources(resources: [PostsResourceInfo]) throws {
        let model = try storage.data() ?? .makeDefault()
        var trackingStates = [ResourceTrackingState]()
        for resource in resources {
            let isTracked = model.resourcesTrackingStates.first(where: { $0.resource.id == resource.id })?.isTacked ?? true
            let new = ResourceTrackingState(
                resource: resource,
                isTacked: isTracked
            )
            trackingStates.append(new)
        }
        let newModel = model.byAdding(.resourcesTrackingStates(trackingStates))
        _ = try storage.update(data: newModel)
    }
    
    func isTrackableResource(resource: PostsResourceInfo?) -> Bool {
        guard let id = resource?.id else { return false }
        let settings = try? storage.data()
        return settings?.resourcesTrackingStates.first(where: { $0.resource.id == id })?.isTacked ?? false
    }
    
    private enum AppSettingsUseCaseError: Error {
        case emptyData
        case invalidRefreshTimeInterval
    }
}
