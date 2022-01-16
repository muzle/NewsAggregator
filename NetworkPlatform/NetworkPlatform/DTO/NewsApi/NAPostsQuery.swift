import Foundation

internal enum NAPostsQuerySortType: String, Hashable, Encodable {
    case pubDate = "publishedAt"
}

internal struct NAPostsQuery: Encodable {
    let token: String
    let country: String?
    let category: String?
    let from: Date?
    let sort: NAPostsQuerySortType?
    
    enum CodingKeys: String, CodingKey {
        case token = "apiKey"
        case country, category, from
        case sort = "sortBy"
    }
}
