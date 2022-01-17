import Foundation
import Domain

struct ResourceTrackingState: Codable, Hashable, AutoSetable {
    let resource: PostsResourceInfo
    var isTacked: Bool
}
