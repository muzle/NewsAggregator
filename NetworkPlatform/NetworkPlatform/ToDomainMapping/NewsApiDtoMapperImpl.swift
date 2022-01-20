import Foundation
import Domain

final class NewsApiDtoMapper {
    private let encoder: JSONEncoder
    private let resourceInfo: PostsResourceInfo
    private let shaService: SHAService
    
    init(
        encoder: JSONEncoder,
        resourceInfo: PostsResourceInfo,
        shaService: SHAService
    ) {
        self.encoder = encoder
        self.resourceInfo = resourceInfo
        self.shaService = shaService
    }
}

// MARK: - Implement DtoMapper

extension NewsApiDtoMapper: DtoMapper {
    func map(_ result: NAPostsContainer) throws -> PostsContainer {
        let posts = try result.posts.map(makePost(_:))
        
        return PostsContainer(
            id_: resourceInfo.id,
            name_: resourceInfo.name,
            image_: nil,
            url_: resourceInfo.url,
            description_: nil,
            posts_: posts
        )
    }
    
    private func makePost(_ naPost: NAPost) throws -> Post {
        let id = try shaService.sha(for: naPost, with: encoder)
        
        return Post(
            id_: id,
            author_: Author(name_: naPost.author),
            link_: naPost.url,
            publicationDate_: naPost.publishedAt,
            title_: naPost.title,
            description_: naPost.description,
            category_: nil,
            image_: Image(url_: naPost.urlToImage),
            sourceId_: resourceInfo.id,
            sourceName_: resourceInfo.name,
            sourceLink_: resourceInfo.url
        )
    }
}
