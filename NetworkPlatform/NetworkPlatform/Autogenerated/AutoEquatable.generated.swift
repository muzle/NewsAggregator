// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    switch (lhs, rhs) {
    case let (lValue?, rValue?):
        return compare(lValue, rValue)
    case (nil, nil):
        return true
    default:
        return false
    }
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lhsItem) in lhs.enumerated() {
        guard compare(lhsItem, rhs[idx]) else { return false }
    }

    return true
}


// MARK: - AutoEquatable for classes, protocols, structs
// MARK: - RssChanelImage AutoEquatable
extension RssChanelImage: Equatable {}
internal func == (lhs: RssChanelImage, rhs: RssChanelImage) -> Bool {
    guard compareOptionals(lhs: lhs.url, rhs: rhs.url, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.title, rhs: rhs.title, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.link, rhs: rhs.link, compare: ==) else { return false }
    guard lhs.width == rhs.width else { return false }
    guard compareOptionals(lhs: lhs.height, rhs: rhs.height, compare: ==) else { return false }
    return true
}
// MARK: - RssChannel AutoEquatable
extension RssChannel: Equatable {}
internal func == (lhs: RssChannel, rhs: RssChannel) -> Bool {
    guard compareOptionals(lhs: lhs.language, rhs: rhs.language, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.title, rhs: rhs.title, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.description, rhs: rhs.description, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.link, rhs: rhs.link, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.image, rhs: rhs.image, compare: ==) else { return false }
    guard lhs.items == rhs.items else { return false }
    guard compareOptionals(lhs: lhs.pubDate, rhs: rhs.pubDate, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.ttl, rhs: rhs.ttl, compare: ==) else { return false }
    return true
}
// MARK: - RssEnclosure AutoEquatable
extension RssEnclosure: Equatable {}
internal func == (lhs: RssEnclosure, rhs: RssEnclosure) -> Bool {
    guard compareOptionals(lhs: lhs.url, rhs: rhs.url, compare: ==) else { return false }
    return true
}
// MARK: - RssPost AutoEquatable
extension RssPost: Equatable {}
internal func == (lhs: RssPost, rhs: RssPost) -> Bool {
    guard compareOptionals(lhs: lhs.guid, rhs: rhs.guid, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.author, rhs: rhs.author, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.title, rhs: rhs.title, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.description, rhs: rhs.description, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.pubDate, rhs: rhs.pubDate, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.category, rhs: rhs.category, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.link, rhs: rhs.link, compare: ==) else { return false }
    guard compareOptionals(lhs: lhs.enclosure, rhs: rhs.enclosure, compare: ==) else { return false }
    return true
}

// MARK: - AutoEquatable for Enums
// swiftlint:enable all
