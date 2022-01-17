import Foundation
import Domain
import RealmPlatform
import CoreDataPlatform
import NetworkPlatform

final class ContextBuilder {
    private typealias UDStorageFactory = UserDefaultsSingleObjectStorageFactory
    func build() -> Context {
        
        let storageAndProviderRepo: Domain.PostsRepository & Domain.PostsStoreRepository  = CoreDataPlatform.RepositoryFactory.makeRepository()
        
        let postsUseCase = PostsUseCaseImpl(
            postsloaders: [
                NetworkPlatform.NetworkRepositoryFactory.makeGazetaRuRepository(),
                NetworkPlatform.NetworkRepositoryFactory.makeLentaRuRepository(),
                NetworkPlatform.NetworkRepositoryFactory.makeNewsApiRepository()
            ],
            postsVisitTraker: RealmPlatform.RepositoryFactory.makeVisitedPostsRepository(),
            favoritePostsTraker: RealmPlatform.RepositoryFactory.makeFavoritePostsRepository(),
            postsProvider: storageAndProviderRepo,
            postsStorage: storageAndProviderRepo,
            imageRepository: NetworkPlatform.NetworkRepositoryFactory.makeImageRepository()
        )
        
        let appSettingsService = AppSettingsServiceImpl(
            storage: UDStorageFactory.makeAppSettingsStorage()
        )
        
        return Context(
            postsUseCase: postsUseCase,
            appSettingsService: appSettingsService,
            dateToStringConverter: DateToStringConverterImpl()
        )
    }
}
