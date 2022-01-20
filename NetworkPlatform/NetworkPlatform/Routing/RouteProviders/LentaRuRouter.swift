import Foundation
import ApiRouter

enum LentaRuRouter {
    case posts
}

// MARK: - Implement AbstractRouter

extension LentaRuRouter: AbstractRouter {
    var host: String {
        "lenta.ru"
    }
    
    var path: String {
        "/rss"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryParameters: Encodable? { nil }
    var body: Encodable? { nil }
}
