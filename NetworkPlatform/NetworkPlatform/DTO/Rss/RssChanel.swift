import Foundation

internal class RssChannel: Decodable, AutoEquatable {
    /// Channel language.
    var language: String?
    /// Channel name. If you have a website that contains some information about a channel,
    /// then the channel name mentioned on the site must match the name described in this element.
    var title: String?
    /// A phrase or sentence describing a channel.
    var description: String?
    /// The URL of the website associated with this channel.
    var link: String?
    /// Specifies a GIF, JPEG, or PNG image that can be associated with a channel.
    var image: RssChanelImage?
    var items: [RssPost] = []
    /// The posting date of the content of the channel, which complies with RFC 822.
    var pubDate: String?
    /// Sets the time to live. This is a number in minutes that indicates how long a channel can be cached without being updated from the source.
    var ttl: Int?
}
