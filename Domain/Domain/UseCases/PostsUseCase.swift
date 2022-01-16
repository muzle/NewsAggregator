import UIKit
import RxSwift

public protocol PostsUseCase {
    func posts() -> Observable<[Post]>
    func image(for post: Post) -> Observable<UIImage?>
    
    func visit(post: Post) -> Single<Void>
    func numberOfVisit(post: Post) -> Observable<Int>
    
    func changeFavoriteState(post: Post) -> Single<Void>
    func favoritePosts() -> Observable<[Post]>
    func postIsFavorite(post: Post) -> Observable<Bool>
}
