import Foundation
import Domain
import RxSwift

final class PostsRepository<PostsDAO: DAO>: FavoritePostsRepository, VisitedPostsRepository where PostsDAO.CommonEntity == Post {
    private let postsDao: PostsDAO
    
    init(
        postsDao: PostsDAO
    ) {
        self.postsDao = postsDao
    }
    
    func favoritePosts() -> Observable<[Domain.Post]> {
        postsDao
            .query(
                with: NSPredicate(format: "isFavorite == %@", NSNumber(value: true)),
                sortDescriptors: [
                    .init(key: "addToFavoriteDate", ascending: true)
                ]
            )
            .mapToDomain()
    }
    
    func changeFavoriteState(for post: Domain.Post) -> Single<Domain.Post> {
        let currentPost = postsDao
            .query(
                with: NSPredicate(format: "uid == %@", post.id),
                sortDescriptors: []
            )
            .map { $0.first }
        
        let updatePost = currentPost
            .compactMap { $0 }
            .map { $0.byAdding(.isFavorite(!$0.isFavorite), .addToFavoriteDate(!$0.isFavorite ? Date() : nil)) }
        let newPost = currentPost
            .map { $0 == nil }
            .map { [self] _ in mapToPost(post: post, isFavorite: true, addToFavoriteDate: Date(), visitCount: 0) }
        
        return Observable
            .merge(updatePost, newPost)
            .take(1)
            .asSingle()
            .flatMap(postsDao.saveOrUpdate(entity:))
            .map { $0.asDomain() }
    }
    
    func postIsVavorite(post: Domain.Post) -> Observable<Bool> {
        postsDao
            .query(
                with: NSPredicate(format: "uid == %@", post.id),
                sortDescriptors: []
            )
            .map { $0.first?.isFavorite ?? false }
    }
    
    func visitedPosts() -> Observable<[Domain.Post]> {
        postsDao
            .query(
                with: NSPredicate(format: "visitCount > %@", NSNumber(value: 0)),
                sortDescriptors: [
                    NSSortDescriptor(key: "visitCount", ascending: true)
                ]
            )
            .map { $0.map { $0.asDomain() } }
    }
    
    func didVisit(for post: Domain.Post) -> Single<Domain.Post> {
        let visitedPost = postsDao
            .query(
                with: NSPredicate(format: "uid == %@", post.id),
                sortDescriptors: []
            )
            .map { $0.first }
        
        let updatePost = visitedPost
            .compactMap { $0?.byAdding(.visitCount(($0?.visitCount ?? 0) + 1)) }
        let newPost = visitedPost
            .map { $0 == nil }
            .map { [self] _ in mapToPost(post: post, isFavorite: false, addToFavoriteDate: nil, visitCount: 1) }
        
        return Observable
            .merge(updatePost, newPost)
            .take(1)
            .asSingle()
            .flatMap(postsDao.saveOrUpdate(entity:))
            .map { $0.asDomain() }
    }
    
    func countOfVisit(post: Domain.Post) -> Observable<Int> {
        postsDao
            .query(
                with: NSPredicate(format: "uid == %@", post.id),
                sortDescriptors: []
            )
            .map { $0.first?.visitCount ?? 0 }
    }
    
    private func mapToPost(post: Domain.Post, isFavorite: Bool, addToFavoriteDate: Date?, visitCount: Int) -> Post {
        Post(
            uid: post.id,
            authorName: post.author?.name,
            authorEmail: post.author?.email,
            link: post.link?.absoluteString,
            publicationDate: post.publicationDate,
            title: post.title,
            postDescription: post.description,
            category: post.category,
            imageUrl: post.image?.url?.absoluteString,
            isFavorite: isFavorite,
            addToFavoriteDate: addToFavoriteDate,
            visitCount: visitCount,
            sourceName: post.sourceName,
            sourceURL: post.sourceLink?.absoluteString
        )
    }
}
