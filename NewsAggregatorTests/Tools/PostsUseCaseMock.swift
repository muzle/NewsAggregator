import Foundation
import Domain
import RxSwift

final class PostsUseCaseMock: PostsUseCase {
    private let postsArray: [Post]
    private let image: UIImage?
    
    init(
        posts: [Post],
        image: UIImage?
    ) {
        self.postsArray = posts
        self.image = image
    }
    
    func posts() -> Observable<[Post]> {
        .just(postsArray)
    }
    
    func image(for post: Post) -> Observable<UIImage?> {
        .just(image)
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
