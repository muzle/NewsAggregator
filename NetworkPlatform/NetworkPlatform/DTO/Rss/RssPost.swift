import Foundation
import Domain

internal class RssPost: Decodable, AutoEquatable {
    /// A string that uniquely identifies the publication.
    var guid: String?
    /// E-mail address of the author of the publication.
    var author: String?
    /// Title.
    var title: String?
    /// Synopsis of the publication (short review) or full version of the publication.
    var description: String?
    /// Date and time of posting, conforming to RFC 822.
    var pubDate: String?
    /// Post category or categories.
    var category: String?
    var link: String?
    /// Description of the media object that is attached to the publication.
    var enclosure: RssEnclosure?
    
    func asDomaim(
        with source: PostSource?,
        dateFormatter: DateFormatter
    ) -> Post {
        var linkURL: URL?
        if let link = link {
            linkURL = URL(string: link)
        }
        var date: Date?
        if let pubDate = pubDate {
            date = dateFormatter.date(from: pubDate)
        }
        var image: Image?
        if
            let enclosureUrl = enclosure?.url,
            let imageUrl = URL(string: enclosureUrl) {
            image = .init(url_: imageUrl)
        }
        
        return Post(
            id_: "",
            author_: nil,
            link_: linkURL,
            publicationDate_: date,
            title_: title,
            description_: description,
            category_: category,
            image_: image,
            source_: source
        )
    }
}
