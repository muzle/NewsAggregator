import Foundation
import Domain
import RealmPlatform
import CoreDataPlatform
import NetworkPlatform

// swiftlint:disable line_length
final class ContextBuilder {
    private typealias UDStorageFactory = UserDefaultsSingleObjectStorageFactory
    func build() -> Context {
        
        let storageAndProviderRepo: Domain.QueryablePostsRepository & Domain.PostsStoreRepository = CoreDataPlatform.RepositoryFactory.makeRepository()
        
        let appSettingsService = AppSettingsServiceImpl(
            storage: UDStorageFactory.makeAppSettingsStorage()
        )
        
        let postsLoaders: [PostsResourceRepository] = [
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
        
        let postsProvider = PostsProvider(
            appSettingsService: appSettingsService,
            queryablePostsRepository: storageAndProviderRepo
        )
        
        let postsUseCase = PostsUseCaseImpl(
            postsFetcher: postsFetcher,
            postsUpdater: postsUpdater,
            postsVisitTraker: RealmPlatform.RepositoryFactory.makeVisitedPostsRepository(),
            favoritePostsTraker: RealmPlatform.RepositoryFactory.makeFavoritePostsRepository(),
            postsProvider: postsProvider,
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
// swiftlint:enable line_length
