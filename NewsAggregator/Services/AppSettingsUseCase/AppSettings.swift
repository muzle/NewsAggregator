import Foundation

struct AppSettings: Codable, AutoSetable {
    var refreshTimeInternalMin: Int
    var resourcesTrackingStates: [ResourceTrackingState]
    
    static func makeDefault() -> Self {
        .init(
            refreshTimeInternalMin: 10,
            resourcesTrackingStates: []
        )
    }
}
