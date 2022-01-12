import Foundation

internal enum NAPostsQuerySortType: String, Hashable, Encodable {
    case pubDate = "publishedAt"
}

internal struct NAPostsQuery: Encodable {
    let token: String
    let query: String?
    let from: Date?
    let sort: NAPostsQuerySortType?
    
    enum CodingKeys: String, CodingKey {
        case token = "apiKey"
        case query = "q"
        case from
        case sort = "sortBy"
    }
}
