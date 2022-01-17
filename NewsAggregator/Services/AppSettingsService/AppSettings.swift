import Foundation

struct AppSettings: Codable, Hashable, AutoSetable {
    var refreshTimeInternalMin: Int
    var resourcesTrackingStates: [ResourceTrackingState]
    
    mutating
    func setNewTrackedState(for resourceId: String, value: Bool) {
        guard let id = resourcesTrackingStates.firstIndex(where: { $0.resource.id == resourceId }) else { return }
        let new = resourcesTrackingStates[id].byAdding(.isTacked(value))
        resourcesTrackingStates[id] = new
    }
    
    static func makeDefault() -> Self {
        .init(
            refreshTimeInternalMin: 10,
            resourcesTrackingStates: []
        )
    }
}
