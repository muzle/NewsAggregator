import Foundation
import RxSwift

public protocol PostsStoreRepository {
    func save(posts: [Post]) -> Single<Void>
}
