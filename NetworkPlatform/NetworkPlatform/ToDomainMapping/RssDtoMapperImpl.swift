import Foundation
import Domain

final class RssDtoMapperImpl {
    private let dateFormatter: DateFormatter
    private let emailChecker: EmailChecker
    private let resourceId: String
    private let resourceName: String
    private let resourceUrl: URL?
    
    init(
        dateFormatter: DateFormatter,
        emailChecker: EmailChecker,
        resourceId: String,
        resourceName: String,
        resourceUrl: URL?
    ) {
        self.dateFormatter = dateFormatter
        self.emailChecker = emailChecker
        self.resourceId = resourceId
        self.resourceName = resourceName
        self.resourceUrl = resourceUrl
    }
}

// MARK: - Implement DtoMapper

extension RssDtoMapperImpl: DtoMapper {
    func map(_ result: RssChannel) -> PostsContainer {
        let posts = result.items.map { post in makePost(post, sourceName: resourceName, sourceURL: self.resourceUrl) }
        
        var image: Image?
        if let imageUrlStr = result.image?.url, let imageUrl = URL(string: imageUrlStr) {
            image = .init(url_: imageUrl)
        }
        
        var resourceUrl: URL?
        if let link = result.link {
            resourceUrl = URL(string: link)
        }
        
        return PostsContainer(
            id_: resourceId,
            name_: result.title,
            image_: image,
            url_: resourceUrl,
            description_: result.description,
            posts_: posts
        )
    }
    
    private func makePost(_ rssPost: RssPost, sourceName: String, sourceURL: URL?) -> Post {
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
        
        return Post(
            id_: "\(rssPost.hashValue)",
            author_: author,
            link_: url,
            publicationDate_: date,
            title_: rssPost.title,
            description_: rssPost.description,
            category_: rssPost.category,
            image_: image,
            sourceName_: sourceName,
            sourceLink_: sourceURL
        )
    }
}
