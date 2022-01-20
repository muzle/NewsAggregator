import Foundation
import ApiRouter

final class LentaPostsRouter: PostsRouter {
    func postsRequest() -> URLRequestConvertible {
        LentaRuRouter.posts
    }
}
