import Foundation

public struct PostsContainer: AutoInit, Equatable {
    let id: String
    let name: String?
    let image: Image?
    let url: URL?
    let description: String?
    let posts: [Post]
}
