import Foundation

internal struct NAPost: Codable, Hashable {
    let source: NASource?
    let author, title, description, content: String?
    let url, urlToImage: URL?
    let publishedAt: Date?
}
