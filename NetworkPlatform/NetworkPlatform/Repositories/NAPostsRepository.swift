import Foundation
import Domain
import RxSwift

// swiftlint:disable line_length
internal class NAPostsRepository<Loader: NetworkLoader, Mapper: DtoMapper>: RootRepository<Loader>, PostsResourceRepository where Mapper.Result == NAPostsContainer {
    private let mapper: Mapper
    private let postsRouter: PostsRouter
    let postsResourceInfo: PostsResourceInfo
    
    init(
        loader: Loader,
        mapper: Mapper,
        postsRouter: PostsRouter,
        sourceInfo: PostsResourceInfo
    ) {
        self.mapper = mapper
        self.postsRouter = postsRouter
        self.postsResourceInfo = sourceInfo
        super.init(loader: loader)
    }
    
    func posts() -> Observable<[Post]> {
        load(
            requestConvertible: postsRouter.postsRequest(),
            encoder: JSONEncoderFactory.commomEncoder,
            decoder: JSONDecoderFactory.dateDecoder
        )
            .map { [mapper] in try mapper.map($0)  }
            .asObservable()
            .map { $0.posts }
    }
}
// swiftlint:enable line_length
