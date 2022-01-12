// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all


// MARK: - AutoHashable for classes, protocols, structs
// MARK: - RssChanelImage AutoHashable
extension RssChanelImage: Hashable {
    internal func hash(into hasher: inout Hasher) {
        url.hash(into: &hasher)
        title.hash(into: &hasher)
        link.hash(into: &hasher)
        width.hash(into: &hasher)
        height.hash(into: &hasher)
    }
}
// MARK: - RssChannel AutoHashable
extension RssChannel: Hashable {
    internal func hash(into hasher: inout Hasher) {
        language.hash(into: &hasher)
        title.hash(into: &hasher)
        description.hash(into: &hasher)
        link.hash(into: &hasher)
        image.hash(into: &hasher)
        items.hash(into: &hasher)
        pubDate.hash(into: &hasher)
        ttl.hash(into: &hasher)
    }
}
// MARK: - RssEnclosure AutoHashable
extension RssEnclosure: Hashable {
    internal func hash(into hasher: inout Hasher) {
        url.hash(into: &hasher)
    }
}
// MARK: - RssPost AutoHashable
extension RssPost: Hashable {
    internal func hash(into hasher: inout Hasher) {
        guid.hash(into: &hasher)
        author.hash(into: &hasher)
        title.hash(into: &hasher)
        description.hash(into: &hasher)
        pubDate.hash(into: &hasher)
        category.hash(into: &hasher)
        link.hash(into: &hasher)
        enclosure.hash(into: &hasher)
    }
}

// MARK: - AutoHashable for Enums
