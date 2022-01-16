import Foundation
import Domain
import RxSwift

final class PostsUseCaseImpl: Domain.PostsUseCase {
    private let postsloaders: [Domain.PostsRepository]
    private let postsVisitTraker: Domain.VisitedPostsRepository
    private let favoritePostsTraker: Domain.FavoritePostsRepository
    private let postsProvider: Domain.PostsRepository
    private let postsStorage: Domain.PostsStoreRepository
    private let imageRepository: Domain.ImageRepository
    
    private let disposeBag = DisposeBag()
    
    init(
        postsloaders: [Domain.PostsRepository],
        postsVisitTraker: Domain.VisitedPostsRepository,
        favoritePostsTraker: Domain.FavoritePostsRepository,
        postsProvider: Domain.PostsRepository,
        postsStorage: Domain.PostsStoreRepository,
        imageRepository: Domain.ImageRepository
    ) {
        self.postsloaders = postsloaders
        self.postsVisitTraker = postsVisitTraker
        self.favoritePostsTraker = favoritePostsTraker
        self.postsProvider = postsProvider
        self.postsStorage = postsStorage
        self.imageRepository = imageRepository
        configure()
    }
    
    private func configure() {
        Observable
            .merge(postsloaders.map { $0.posts() })
            .flatMap(postsStorage.save(posts:))
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func posts() -> Observable<[Post]> {
        postsProvider.posts()
    }
    
    func image(for post: Post) -> Observable<UIImage?> {
        imageRepository.image(with: post.image?.url)
            .asObservable()
            .mapToOptional()
    }
    
    func visit(post: Post) -> Single<Void> {
        postsVisitTraker.didVisit(for: post)
            .mapToVoid()
    }
    
    func numberOfVisit(post: Post) -> Observable<Int> {
        postsVisitTraker
            .countOfVisit(post: post)
    }
    
    func changeFavoriteState(post: Post) -> Single<Void> {
        favoritePostsTraker
            .changeFavoriteState(for: post)
            .mapToVoid()
    }
    
    func favoritePosts() -> Observable<[Post]> {
        favoritePostsTraker.favoritePosts()
    }
    
    func postIsFavorite(post: Post) -> Observable<Bool> {
        favoritePostsTraker.postIsVavorite(post: post)
    }
}
