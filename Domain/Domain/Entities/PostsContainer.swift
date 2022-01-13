import Foundation

public struct PostsContainer: AutoInit, Hashable {
    let id: String
    let name: String?
    let image: Image?
    let url: URL?
    let description: String?
    let posts: [Post]
}
