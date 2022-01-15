import Foundation
import Domain

public enum RepositoryFactory {
    internal static let dbLoader = DBLoader()
    internal static let postsDao = DAOImpl<Post>(context: dbLoader.context)
    
    public static func makeRepository() -> Domain.PostsRepository & Domain.PostsStoreRepository {
        PostsRepository(postsDao: postsDao)
    }
}
