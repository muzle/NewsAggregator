import Foundation

internal struct NAPostsContainer: Codable, Hashable {
    let posts: [NAPost]
    
    enum CodingKeys: String, CodingKey {
        case posts = "articles"
    }
}
