import Foundation
import RxSwift

public protocol PostsRepository {
    func posts() -> Observable<[Post]>
}
