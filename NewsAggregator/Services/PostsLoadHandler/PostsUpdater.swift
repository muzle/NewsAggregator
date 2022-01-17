import Foundation
import Domain
import RxSwift
import RxRelay

final class PostsUpdater {
    private let postsFetcher: PostsRepository
    private let appSettingsService: AppSettingsService
    private let updatePostsRelay = PublishRelay<Void>()
    private var dispatchWorkItem: DispatchWorkItem?
    private let queue: DispatchQueue
    private var startLoadDate: Date?
    private let disposeBag = DisposeBag()
    
    init(
        postsFetcher: PostsRepository,
        appSettingsService: AppSettingsService,
        queue: DispatchQueue = .global(qos: .background)
    ) {
        self.postsFetcher = postsFetcher
        self.appSettingsService = appSettingsService
        self.queue = queue
    }
    
    private func configure() {
        appSettingsService.settings()
            .map { $0.refreshTimeInternalMin }
            .distinctUntilChanged()
            .skip(1)
            .subscribe(onNext: didChangeTimeInterval(minCount:))
            .disposed(by: disposeBag)
    }
    
    private func didChangeTimeInterval(minCount: Int) {
        guard
            let startLoadDate = startLoadDate,
            let minCountFromStart = Calendar.current.dateComponents([.minute], from: startLoadDate, to: Date()).minute
        else { return }
        let newMinCount = max(minCount - minCountFromStart, 0)
        putUpdateTaskToQueue(minCount: newMinCount)
    }
    
    private func startLoadPosts() {
        startLoadDate = Date()
    }
    
    private func didLoadPosts() {
        repeatUpdateTask()
    }
    
    private func repeatUpdateTask() {
        guard let minCount = try? appSettingsService.settingsModel().refreshTimeInternalMin else { return }
        putUpdateTaskToQueue(minCount: minCount)
    }
    
    private func putUpdateTaskToQueue(minCount: Int) {
        dispatchWorkItem?.cancel()
        let task = DispatchWorkItem { [updatePostsRelay] in updatePostsRelay.accept(()) }
        dispatchWorkItem = task
        queue.asyncAfter(deadline: .now() + .seconds(minCount * 60), execute: task)
    }
}

// MARK: - Implement PostsRepository

extension PostsUpdater: PostsRepository {
    func posts() -> Observable<[Post]> {
        updatePostsRelay
            .asObservable()
            .startWith(())
            .do(onNext: { [self] _ in startLoadPosts() })
            .flatMap(postsFetcher.posts)
            .do(afterNext: { [self] _ in didLoadPosts() })
    }
}
