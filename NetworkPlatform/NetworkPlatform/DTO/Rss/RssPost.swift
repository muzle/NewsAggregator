import Foundation

internal final class RssPost: Codable, AutoEquatable, AutoHashable {
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
}
