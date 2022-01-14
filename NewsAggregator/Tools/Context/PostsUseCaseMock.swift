import Foundation
import Domain
import RxSwift
import NetworkPlatform

final class PostsUseCaseMock: PostsUseCase {
    private let postsArray: [Post] = [
        .init(id_: "g", author_: nil, link_: .init(string: "https://lenta.ru/news/2022/01/14/passport/"), publicationDate_: Date(), title_: "Hello", description_: "Hello descr", category_: "Category", image_: .init(url_: .init(string: "https://icdn.lenta.ru/images/2022/01/13/15/20220113155257288/pic_0f467557db2f084c76dbd1e3722274cc.jpg"))),
        .init(id_: "g", author_: nil, link_: nil, publicationDate_: Date(), title_: "goodby", description_: "goodby descr", category_: "goodby Category", image_: nil)
    ]
    private var visitedPostsArray = [Post]()
    private var favoritePostsArray = [Post]()
    private var numberOfVisitDict = [Post: Int]()
    
    let imageRepository = NetworkPlatform.NetworkRepositoryFactory.makeImageRepository()
    
    func posts() -> Observable<[Post]> {
        .just(postsArray)
    }
    
    func image(for post: Post) -> Observable<UIImage?> {
        imageRepository.image(with: post.image?.url)
            .asObservable()
            .map { UIImage?($0) }
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
