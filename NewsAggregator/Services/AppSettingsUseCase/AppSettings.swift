import Foundation

struct AppSettings: Codable, AutoSetable {
    var refreshTimeInternalMin: Int
    
    static func makeDefault() -> Self {
        .init(
            refreshTimeInternalMin: 10
        )
    }
}
