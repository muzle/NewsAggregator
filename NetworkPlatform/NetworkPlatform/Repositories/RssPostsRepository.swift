import Foundation
import Domain
import RxSwift

// swiftlint:disable line_length
internal class RssPostsRepository<Loader: NetworkLoader, Mapper: DtoMapper>: RootRepository<Loader>, Domain.PostsResourceRepository where Mapper.Result == RssChannel {
    private let mapper: Mapper
    private let rssDecoder: RssDecoder
    private let postsRouter: PostsRouter
    let postsResourceInfo: PostsResourceInfo
    
    init(
        loader: Loader,
        rssDecoder: RssDecoder,
        mapper: Mapper,
        postsRouter: PostsRouter,
        sourceInfo: PostsResourceInfo
    ) {
        self.mapper = mapper
        self.rssDecoder = rssDecoder
        self.postsResourceInfo = sourceInfo
        self.postsRouter = postsRouter
        super.init(loader: loader)
    }
    
    func posts() -> Observable<[Post]> {
        loadData(requestConvertible: postsRouter.postsRequest())
            .map(rssDecoder.decode(data:))
            .map(mapper.map(_:))
            .map { $0.posts }
            .asObservable()
    }
}
// swiftlint:enable line_length
