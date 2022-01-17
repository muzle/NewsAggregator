import Foundation
import Domain
import RxSwift
import RxCocoa

final class PostsFetcher {
    private let appSettingsService: AppSettingsService
    private let postsLoaders: [PostsRepository]
    
    init(
        appSettingsService: AppSettingsService,
        postsLoaders: [PostsRepository]
    ) {
        self.appSettingsService = appSettingsService
        self.postsLoaders = postsLoaders
    }
}

// MARK: - Implement PostsRepository

extension PostsFetcher: PostsRepository {
    func posts() -> Observable<[Post]> {
        let repositories = postsLoaders
            .filter { [appSettingsService] repository in
                appSettingsService.isTrackableResource(resource: repository.postsResourceInfo)
            }
            .map { $0.posts() }
        return Observable.merge(repositories)
    }
}
