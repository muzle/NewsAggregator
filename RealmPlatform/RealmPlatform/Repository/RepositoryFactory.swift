import Foundation
import Domain

public enum RepositoryFactory {
    private static let posts = PostsRepository(postsDao: DAOImpl<Post>(configuration: RealmConfigurationFactory.makePostsConfiguration()))
    
    public static func makeFavoritePostsRepository() -> FavoritePostsRepository {
        posts
    }
    
    public static func makeVisitedPostsRepository() -> VisitedPostsRepository {
        posts
    }
}
