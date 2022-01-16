import Foundation
import Domain

final class NewsApiDtoMapper {
    private let resourceId: String
    private let imageUrl: URL?
    private let name: String?
    private let title: String?
    private let description: String?
    private let resourceURL: URL
    private let resourceName: String
    
    init(
        resourceId: String,
        imageUrl: URL? = nil,
        name: String? = nil,
        title: String? = nil,
        description: String? = nil,
        resourceURL: URL,
        resourceName: String
    ) {
        self.resourceId = resourceId
        self.imageUrl = imageUrl
        self.name = name
        self.title = title
        self.description = description
        self.resourceURL = resourceURL
        self.resourceName = resourceName
    }
}

// MARK: - Implement DtoMapper

extension NewsApiDtoMapper: DtoMapper {
    func map(_ result: NAPostsContainer) -> PostsContainer {
        let posts = result.posts.map(makePost(_:))
        
        var image: Image?
        if let imageUrl = imageUrl {
            image = .init(url_: imageUrl)
        }
        
        return PostsContainer(
            id_: resourceId,
            name_: title,
            image_: image,
            url_: resourceURL,
            description_: description,
            posts_: posts
        )
    }
    
    private func makePost(_ naPost: NAPost) -> Post {
        Post(
            id_: "\(naPost.hashValue)",
            author_: Author(name_: naPost.author),
            link_: naPost.url,
            publicationDate_: naPost.publishedAt,
            title_: naPost.title,
            description_: naPost.description,
            category_: nil,
            image_: Image(url_: naPost.urlToImage),
            sourceName_: resourceName,
            sourceLink_: resourceURL
        )
    }
}
