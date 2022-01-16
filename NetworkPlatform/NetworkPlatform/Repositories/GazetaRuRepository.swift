import Foundation
import Domain
import RxSwift

// swiftlint:disable line_length
internal class GazetaRuRepository<Loader: NetworkLoader, Mapper: DtoMapper>: RootRepository<Loader>, Domain.PostsRepository where Mapper.Result == RssChannel {
    private let mapper: Mapper
    private let rssDecoder: RssDecoder
    
    init(loader: Loader, rssDecoder: RssDecoder, mapper: Mapper) {
        self.mapper = mapper
        self.rssDecoder = rssDecoder
        super.init(loader: loader)
    }
    
    func posts() -> Observable<[Post]> {
        loadData(requestConvertible: GazetaRuRouter.posts)
            .map(rssDecoder.decode(data:))
            .map(mapper.map(_:))
            .map { $0.posts }
            .asObservable()
    }
}
// swiftlint:enable line_length
