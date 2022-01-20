import Foundation
import ApiRouter

enum NewsApiRouter {
    case posts(query: Encodable)
}

// MARK: - Implement AbstractRouter

extension NewsApiRouter: AbstractRouter {
    var host: String {
        "newsapi.org"
    }
    
    var path: String {
        switch self {
        case .posts:
            return "/v2/top-headlines"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryParameters: Encodable? {
        switch self {
        case .posts(let query):
            return query
        }
    }
    
    var body: Encodable? {
        nil
    }
}
