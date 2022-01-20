import Foundation
import Domain

final class RssDtoMapperImpl {
    private let dateFormatter: DateFormatter
    private let encoder: JSONEncoder
    private let emailChecker: EmailChecker
    private let resourceInfo: PostsResourceInfo
    private let shaService: SHAService
    
    init(
        dateFormatter: DateFormatter,
        encoder: JSONEncoder,
        emailChecker: EmailChecker,
        resourceInfo: PostsResourceInfo,
        shaService: SHAService
    ) {
        self.dateFormatter = dateFormatter
        self.encoder = encoder
        self.emailChecker = emailChecker
        self.resourceInfo = resourceInfo
        self.shaService = shaService
    }
}

// MARK: - Implement DtoMapper

extension RssDtoMapperImpl: DtoMapper {
    func map(_ result: RssChannel) throws -> PostsContainer {
        let posts = try result.items.map(makePost(_:))
        
        var image: Image?
        if let imageUrlStr = result.image?.url, let imageUrl = URL(string: imageUrlStr) {
            image = .init(url_: imageUrl)
        }
        
        return PostsContainer(
            id_: resourceInfo.id,
            name_: resourceInfo.name,
            image_: image,
            url_: resourceInfo.url,
            description_: result.description,
            posts_: posts
        )
    }
    
    private func makePost(_ rssPost: RssPost) throws -> Post {
        var date: Date?
        if let pubDate = rssPost.pubDate {
            date = dateFormatter.date(from: pubDate)
        }
        var image: Image?
        if
            let enclosureUrl = rssPost.enclosure?.url,
            let url = URL(string: enclosureUrl) {
            image = Image(url_: url)
        }
        var url: URL?
        if let link = rssPost.link {
            url = URL(string: link)
        }
        var author: Author?
        if let authorStr = rssPost.author {
            let isEmail = emailChecker.isEmail(authorStr)
            author = Author(
                name_: isEmail ? nil : authorStr,
                email_: isEmail ? authorStr : nil
            )
        }
        
        let id = try shaService.sha(for: rssPost, with: encoder)
        
        return Post(
            id_: id,
            author_: author,
            link_: url,
            publicationDate_: date,
            title_: rssPost.title,
            description_: rssPost.description,
            category_: rssPost.category,
            image_: image,
            sourceId_: resourceInfo.id,
            sourceName_: resourceInfo.name,
            sourceLink_: resourceInfo.url
        )
    }
}
