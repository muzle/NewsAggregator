import Foundation

internal struct NAPost: Codable, Equatable {
    let source: NASource?
    let author, title, description, content: String?
    let url, urlToImage: String?
    let publishedAt: String?
}
