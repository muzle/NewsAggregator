import Foundation
import RxSwift

public protocol VisitedPostsRepository {
    func visitedPosts() -> Observable<[Post]>
    func didVisit(for post: Post) -> Single<Post>
    func countOfVisit(post: Post) -> Observable<Int>
}
