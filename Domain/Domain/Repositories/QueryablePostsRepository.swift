import Foundation
import RxSwift

public protocol QueryablePostsRepository: PostsRepository {
    func queryPosts(
        with predicate: NSPredicate,
        sortDescriptors: [NSSortDescriptor]
    ) -> Observable<[Post]>
}
