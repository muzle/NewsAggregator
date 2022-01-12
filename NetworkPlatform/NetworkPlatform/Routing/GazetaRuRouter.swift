import Foundation
import ApiRouter

enum GazetaRuRouter {
    case posts
}

// MARK: - Implement AbstractRouter

extension GazetaRuRouter: AbstractRouter {
    var host: String {
        "gazeta.ru"
    }
    
    var path: String {
        "/export/rss/lenta.xml"
    }
    
    var method: HTTPMethod {
        .get
    }
    var queryParameters: Encodable? { nil }
    var body: Encodable? { nil }
}
