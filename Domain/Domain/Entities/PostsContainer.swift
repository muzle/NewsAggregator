import Foundation

public struct PostsContainer {
    let resourceId: String
    let resourceName: String?
    let resourceImage: Image?
    let resourceUrl: URL?
    let posts: [Post]
}
