import Foundation
import RxSwift

public protocol FavoritePostsRepository {
    func favoritePosts() -> Observable<[Post]>
    func changeFavoriteState(for post: Post) -> Single<Post>
    func postIsVavorite(post: Post) -> Observable<Bool>
}
