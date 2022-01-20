import Foundation
import Domain

// swiftlint:disable line_length
public enum NetworkRepositoryFactory {
    private static let loader = NetworkLoaderImpl()
    private static let shaService = SHA256()
    private static let newsApiMapper = NewsApiDtoMapper(
        encoder: JSONEncoderFactory.commomEncoder,
        resourceInfo: PostsResourceInfoFactory.newsApi,
        shaService: shaService
    )
    private static let lentaMapper = makeRssMapper(resourceInfo: PostsResourceInfoFactory.lenta)
    private static let gazetaMapper = makeRssMapper(resourceInfo: PostsResourceInfoFactory.gazeta)
    private static let emailChecker = EmailCheckerImpl()
    private static func makeRssMapper(resourceInfo: PostsResourceInfo) -> RssDtoMapperImpl {
        RssDtoMapperImpl(
            dateFormatter: Formatter.RFC822,
            encoder: JSONEncoderFactory.commomEncoder,
            emailChecker: emailChecker,
            resourceInfo: resourceInfo,
            shaService: shaService
        )
    }
    private static let rssDecoder = RssDecoderImpl()
    
    public static func makeLentaRuRepository() -> Domain.PostsResourceRepository {
        RssPostsRepository(
            loader: loader,
            rssDecoder: rssDecoder,
            mapper: lentaMapper,
            postsRouter: LentaPostsRouter(),
            sourceInfo: PostsResourceInfoFactory.lenta
        )
    }
    
    public static func makeGazetaRuRepository() -> Domain.PostsResourceRepository {
        RssPostsRepository(
            loader: loader,
            rssDecoder: rssDecoder,
            mapper: lentaMapper,
            postsRouter: GazetaPostsRouter(),
            sourceInfo: PostsResourceInfoFactory.lenta
        )
    }
    
    public static func makeNewsApiRepository() -> Domain.PostsResourceRepository {
        NAPostsRepository(
            loader: loader,
            mapper: newsApiMapper,
            postsRouter: NAPostsRouter(),
            sourceInfo: PostsResourceInfoFactory.newsApi
        )
    }
    
    public static func makeImageRepository() -> Domain.ImageRepository {
        ImageRepositoryImpl()
    }
}
// swiftlint:enable line_length
