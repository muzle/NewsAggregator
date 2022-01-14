import Foundation
import Domain

public enum NetworkRepositoryFactory {
    private static let loader = NetworkLoaderImpl()
    
    public static func makeLentaRuRepository() -> Domain.PostsRepository {
        LentaRuRepository(loader: loader)
    }
    
    public static func makeGazetaRuRepository() -> Domain.PostsRepository {
        GazetaRuRepository(loader: loader)
    }
    
    public static func makeNewsApiRepository() -> Domain.PostsRepository {
        NewsApiRepository(loader: loader)
    }
    
    public static func makeImageRepository() -> Domain.ImageRepository {
        ImageRepositoryImpl()
    }
}
