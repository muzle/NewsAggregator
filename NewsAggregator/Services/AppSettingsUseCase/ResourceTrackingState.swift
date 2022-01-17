import Foundation
import Domain

struct ResourceTrackingState: Codable, AutoSetable {
    let resource: PostsResourceInfo
    var isTacked: Bool
}
