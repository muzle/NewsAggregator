import Foundation
import RxSwift

public protocol PostsRepository {
    func posts() -> Observable<[Post]>
    
    var postsResourceInfo: PostsResourceInfo? { get }
}

public extension PostsRepository {
    var postsResourceInfo: PostsResourceInfo? { nil }
}
