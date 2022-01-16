import Foundation

public struct PostsContainer: AutoInit, Hashable {
    public let id: String
    public let name: String?
    public let image: Image?
    public let url: URL?
    public let description: String?
    public let posts: [Post]
}
