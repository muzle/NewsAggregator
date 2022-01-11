import Foundation

internal enum RssPath: String {
    case chanel = "/rss/channel"
    case chanelDescription = "/rss/channel/description"
    case chanelLanguage = "/rss/channel/language"
    case chanelLink = "/rss/channel/link"
    case chanelTitle = "/rss/channel/title"
    case chanelTtl = "/rss/channel/ttl"
    case chanelPubDate = "/rss/channel/pubDate"
        
    case chanelImage = "/rss/channel/image"
    case chanelImageTitle = "/rss/channel/image/title"
    case chanelImageUrl = "/rss/channel/image/url"
    case chanelImageLink = "/rss/channel/image/link"
    case chanelImageHeight = "/rss/channel/image/height"
    case chanelImageWidth = "/rss/channel/image/width"
        
    case chanelItem = "/rss/channel/item"
    case chanelItemLink = "/rss/channel/item/link"
    case chanelItemAuthor = "/rss/channel/item/author"
    case chanelItemTitle = "/rss/channel/item/title"
    case chanelItemPubDate = "/rss/channel/item/pubDate"
    case chanelItemDescription = "/rss/channel/item/description"
    case chanelItemEnclosure = "/rss/channel/item/enclosure"
    case chanelItemGuid = "/rss/channel/item/guid"
    case chanelItemCategory = "/rss/channel/item/category"
}
