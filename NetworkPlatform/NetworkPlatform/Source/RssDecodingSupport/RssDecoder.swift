import Foundation

internal protocol RssDecoder {
    func decode(data: Data) throws -> RssChannel
}
