import Foundation
import Domain
import RxSwift

internal class GazetaRuRepository<Loader: NetworkLoader>: RootRepository<Loader>, Domain.PostsRepository {
    func posts() -> Observable<[Post]> {
        .never()
    }
}
