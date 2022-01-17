import Foundation
import Domain
import RxSwift

final class PostsProvider {
    private let appSettingsService: AppSettingsService
    private let queryablePostsRepository: QueryablePostsRepository
    
    init(
        appSettingsService: AppSettingsService,
        queryablePostsRepository: QueryablePostsRepository
    ) {
        self.appSettingsService = appSettingsService
        self.queryablePostsRepository = queryablePostsRepository
    }
}

// MARK: - Implement PostsRepository

extension PostsProvider: PostsRepository {
    func posts() -> Observable<[Post]> {
        appSettingsService.settings()
            .flatMap { [self] settings in
                queryablePostsRepository.queryPosts(
                    with: makePredicate(from: settings),
                    sortDescriptors: makeSortDescriptors()
                )
            }
    }
    
    private func makePredicate(from settings: AppSettings) -> NSPredicate? {
        let notTrackableIds = settings.resourcesTrackingStates.filter { !$0.isTacked }.map { $0.resource.id }
        guard !notTrackableIds.isEmpty else { return nil }
        return NSPredicate(format: "NOT (sourceId IN %@)", notTrackableIds)
    }
    
    private func makeSortDescriptors() -> [NSSortDescriptor] {
        [
            NSSortDescriptor(key: "publicationDate", ascending: false)
        ]
    }
}
