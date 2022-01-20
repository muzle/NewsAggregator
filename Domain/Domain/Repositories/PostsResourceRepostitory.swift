import Foundation

public protocol PostsResourceRepository: PostsRepository {
    var postsResourceInfo: PostsResourceInfo { get }
}
