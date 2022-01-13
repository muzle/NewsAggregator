import Foundation
import Domain
import RxSwift

final class PostsUseCaseMock: PostsUseCase {
    private let postsArray = [Post]()
    private var visitedPostsArray = [Post]()
    private var favoritePostsArray = [Post]()
    private var numberOfVisitDict = [Post: Int]()
    
    func posts() -> Observable<[Post]> {
        .never()
    }
    
    func image(for post: Post) -> Observable<UIImage?> {
        .never()
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
