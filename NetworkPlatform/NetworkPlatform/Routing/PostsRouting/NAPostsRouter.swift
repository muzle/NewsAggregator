import Foundation
import ApiRouter

private struct Constants {
    let token = "e37d5dddc223423f80d6d8def5494587"
}
private let constants = Constants()

final class NAPostsRouter: PostsRouter {
    func postsRequest() -> URLRequestConvertible {
        NewsApiRouter.posts(query: makePostsQuery())
    }
    
    private func makePostsQuery() -> Encodable {
        NAPostsQuery(
            token: constants.token,
            country: "ru",
            category: "business",
            from: Date(),
            sort: .pubDate
        )
    }
}
