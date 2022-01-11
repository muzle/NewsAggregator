import Foundation

internal struct NAPostsContainer: Codable, Equatable {
    let posts: [NAPost]
    
    enum CodingKeys: String, CodingKey {
        case posts = "articles"
    }
}
