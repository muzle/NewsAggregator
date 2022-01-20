import Foundation
import ApiRouter

internal extension AbstractRouter {
    var scheme: String { "https" }
    var port: Int? { nil }
    var policy: URLRequest.CachePolicy { .useProtocolCachePolicy }
    var interval: TimeInterval { 60 }
    var headers: HTTPHeaders {
        [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json; charset=utf-8"
        ]
    }
}
