import Foundation
import ApiRouter

protocol PostsRouter {
    func postsRequest() -> URLRequestConvertible
}
