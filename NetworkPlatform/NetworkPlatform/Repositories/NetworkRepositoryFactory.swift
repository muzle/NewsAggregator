import Foundation
import Domain

public enum NetworkRepositoryFactory {
    private static let loader = NetworkLoaderImpl()
    private static let newsApiMapper = NewsApiDtoMapper(
        resourceId: ResourceId.newApi,
        resourceURL: URL(string: "https://newsapi.org"),
        resourceName: "NewsApi"
    )
    private static let emailChecker = EmailCheckerImpl()
    private static let lentaMapper = RssDtoMapperImpl(
        dateFormatter: Formatter.RFC822,
        emailChecker: emailChecker,
        resourceId: ResourceId.lenta,
        resourceName: "Lenta",
        resourceUrl: URL(string: "https://lenta.ru")
    )
    private static let gazetaMapper = RssDtoMapperImpl(
        dateFormatter: Formatter.RFC822,
        emailChecker: emailChecker,
        resourceId: ResourceId.lenta,
        resourceName: "gazeta",
        resourceUrl: URL(string: "https://gazeta.ru")
    )
    private static let rssDecoder = RssDecoderImpl()
    
    public static func makeLentaRuRepository() -> Domain.PostsRepository {
        LentaRuRepository(loader: loader, rssDecoder: rssDecoder, mapper: lentaMapper)
    }
    
    public static func makeGazetaRuRepository() -> Domain.PostsRepository {
        GazetaRuRepository(loader: loader, rssDecoder: rssDecoder, mapper: gazetaMapper)
    }
    
    public static func makeNewsApiRepository() -> Domain.PostsRepository {
        NewsApiRepository(loader: loader, mapper: newsApiMapper)
    }
    
    public static func makeImageRepository() -> Domain.ImageRepository {
        ImageRepositoryImpl()
    }
}
