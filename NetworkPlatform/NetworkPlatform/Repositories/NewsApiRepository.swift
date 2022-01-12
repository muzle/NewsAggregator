import Foundation
import Domain
import RxSwift

internal class NewsApiRepository<Loader: NetworkLoader>: RootRepository<Loader>, Domain.PostsRepository {
    func posts() -> Observable<[Post]> {
        .never()
    }
}
