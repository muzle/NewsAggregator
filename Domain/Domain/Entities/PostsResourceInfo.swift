import Foundation

public struct PostsResourceInfo: Codable, Hashable, AutoInit {
    public let id: String
    public let url: URL?
    public let name: String
}
