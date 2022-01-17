import Foundation
import Domain
import RealmPlatform
import CoreDataPlatform
import NetworkPlatform

final class ContextBuilder {
    private typealias UDStorageFactory = UserDefaultsSingleObjectStorageFactory
    func build() -> Context {
        
        let storageAndProviderRepo: Domain.PostsRepository & Domain.PostsStoreRepository = CoreDataPlatform.RepositoryFactory.makeRepository()
        
        let appSettingsService = AppSettingsServiceImpl(
            storage: UDStorageFactory.makeAppSettingsStorage()
        )
        
        let postsLoaders = [
            NetworkPlatform.NetworkRepositoryFactory.makeGazetaRuRepository(),
            NetworkPlatform.NetworkRepositoryFactory.makeLentaRuRepository(),
            NetworkPlatform.NetworkRepositoryFactory.makeNewsApiRepository()
        ]
        
        let postsFetcher = PostsFetcher(
            appSettingsService: appSettingsService,
            postsLoaders: postsLoaders
        )
        
        let postsUpdater = PostsUpdater(
            postsFetcher: postsFetcher,
            appSettingsService: appSettingsService
        )
        
        let postsUseCase = PostsUseCaseImpl(
            postsFetcher: postsFetcher,
            postsUpdater: postsUpdater,
            postsVisitTraker: RealmPlatform.RepositoryFactory.makeVisitedPostsRepository(),
            favoritePostsTraker: RealmPlatform.RepositoryFactory.makeFavoritePostsRepository(),
            postsProvider: storageAndProviderRepo,
            postsStorage: storageAndProviderRepo,
            imageRepository: NetworkPlatform.NetworkRepositoryFactory.makeImageRepository()
        )
        
        do {
            try appSettingsService.resetTrackableResources(resources: postsLoaders.compactMap { $0.postsResourceInfo })
        } catch {
            print(error.localizedDescription)
        }
        
        return Context(
            postsUseCase: postsUseCase,
            appSettingsService: appSettingsService,
            dateToStringConverter: DateToStringConverterImpl()
        )
    }
}
