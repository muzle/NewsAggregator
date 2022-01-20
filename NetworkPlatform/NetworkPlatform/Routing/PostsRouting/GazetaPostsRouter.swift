import Foundation
import ApiRouter

final class GazetaPostsRouter: PostsRouter {
    func postsRequest() -> URLRequestConvertible {
        GazetaRuRouter.posts
    }
}
