import Foundation
import Domain
import RxSwift

final class PostsUseCaseMock: PostsUseCase {
    private let postsArray: [Post] = [
        .init(id_: "g", author_: nil, link_: nil, publicationDate_: Date(), title_: "Hello", description_: "Hello descr", category_: "Category", image_: .init(url_: .init(string: "/"))),
        .init(id_: "g", author_: nil, link_: nil, publicationDate_: Date(), title_: "goodby", description_: "goodby descr", category_: "goodby Category", image_: nil)
    ]
    private var visitedPostsArray = [Post]()
    private var favoritePostsArray = [Post]()
    private var numberOfVisitDict = [Post: Int]()
    
    func posts() -> Observable<[Post]> {
        .just(postsArray)
    }
    
    func image(for post: Post) -> Observable<UIImage?> {
        .just(Asset.ic60ImagePlaceholder.image)
    }
    
    func visit(post: Post) -> Single<Void> {
        .never()
    }
    
    func numberOfVisit(post: Post) -> Observable<Int> {
        .never()
    }
    
    func changeFavoriteState(post: Post) -> Single<Void> {
        .never()
    }
    
    func favoritePosts() -> Observable<[Post]> {
        .never()
    }
}
