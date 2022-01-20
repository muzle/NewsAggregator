import Foundation
import Domain
import RxSwift

// swiftlint:disable line_length
internal class LentaRuRepository<Loader: NetworkLoader, Mapper: DtoMapper>: RootRepository<Loader>, Domain.PostsResourceRepository where Mapper.Result == RssChannel {
    private let mapper: Mapper
    private let rssDecoder: RssDecoder
    private let sourceInfo: PostsResourceInfo
    
    init(
        loader: Loader,
        rssDecoder: RssDecoder,
        mapper: Mapper,
        sourceInfo: PostsResourceInfo
    ) {
        self.mapper = mapper
        self.rssDecoder = rssDecoder
        self.sourceInfo = sourceInfo
        super.init(loader: loader)
    }
    
    func posts() -> Observable<[Post]> {
        loadData(requestConvertible: LentaRuRouter.posts)
            .map(rssDecoder.decode(data:))
            .map(mapper.map(_:))
            .map { $0.posts }
            .asObservable()
    }
    
    var postsResourceInfo: PostsResourceInfo {
        sourceInfo
    }
}
// swiftlint:enable line_length
