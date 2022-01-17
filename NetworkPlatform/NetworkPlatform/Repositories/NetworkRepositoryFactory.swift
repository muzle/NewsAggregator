import Foundation
import Domain

// swiftlint:disable line_length
public enum NetworkRepositoryFactory {
    private static let loader = NetworkLoaderImpl()
    private static let newsApiMapper = NewsApiDtoMapper(
        encoder: JSONEncoderFactory.commomEncoder,
        resourceInfo: PostsResourceInfoFactory.newsApi
    )
    private static let lentaMapper = makeRssMapper(resourceInfo: PostsResourceInfoFactory.lenta)
    private static let gazetaMapper = makeRssMapper(resourceInfo: PostsResourceInfoFactory.gazeta)
    private static let emailChecker = EmailCheckerImpl()
    private static func makeRssMapper(resourceInfo: PostsResourceInfo) -> RssDtoMapperImpl {
        RssDtoMapperImpl(
            dateFormatter: Formatter.RFC822,
            encoder: JSONEncoderFactory.commomEncoder,
            emailChecker: emailChecker,
            resourceInfo: resourceInfo
        )
    }
    private static let rssDecoder = RssDecoderImpl()
    
    public static func makeLentaRuRepository() -> Domain.PostsRepository {
        LentaRuRepository(
            loader: loader,
            rssDecoder: rssDecoder,
            mapper: lentaMapper,
            sourceInfo: PostsResourceInfoFactory.lenta
        )
    }
    
    public static func makeGazetaRuRepository() -> Domain.PostsRepository {
        GazetaRuRepository(
            loader: loader,
            rssDecoder: rssDecoder,
            mapper: gazetaMapper,
            sourceInfo: PostsResourceInfoFactory.gazeta
        )
    }
    
    public static func makeNewsApiRepository() -> Domain.PostsRepository {
        NewsApiRepository(
            loader: loader,
            mapper: newsApiMapper,
            sourceInfo: PostsResourceInfoFactory.newsApi
        )
    }
    
    public static func makeImageRepository() -> Domain.ImageRepository {
        ImageRepositoryImpl()
    }
}
// swiftlint:enable line_length
