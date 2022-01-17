import Foundation
import Domain
import RxSwift

final class PostsRepository<PostsDAO: DAO>: PostsStoreRepository, QueryablePostsRepository where PostsDAO.Entity == Post {
    private let postsDao: PostsDAO
    
    init(postsDao: PostsDAO) {
        self.postsDao = postsDao
    }
    
    func save(posts: [Post]) -> Single<Void> {
        postsDao
            .saveOrUpdate(entities: posts)
            .map { _ in }
    }
    
    func posts() -> Observable<[Post]> {
        postsDao.query(with: nil, sortDescriptors: [])
    }
    
    func queryPosts(
        with predicate: NSPredicate?,
        sortDescriptors: [NSSortDescriptor]
    ) -> Observable<[Post]> {
        postsDao.query(with: predicate, sortDescriptors: sortDescriptors)
    }
}
