import Foundation

public struct Post: AutoInit {
    public let id: String
    public let author: Author?
    public let link: URL?
    public let publicationDate: Date?
    public let title: String?
    public let description: String?
    public let category: String?
    public let image: Image?
}
