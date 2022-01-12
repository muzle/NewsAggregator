import Foundation
import Domain

public enum NetworkRepositoryFactory {
    private static let loader = NetworkLoaderImpl()
    
    static func makeLentaRuRepository() -> Domain.PostsRepository {
        LentaRuRepository(loader: loader)
    }
    
    static func makeGazetaRuRepository() -> Domain.PostsRepository {
        GazetaRuRepository(loader: loader)
    }
    
    static func makeNewsApiRepository() -> Domain.PostsRepository {
        NewsApiRepository(loader: loader)
    }
}
