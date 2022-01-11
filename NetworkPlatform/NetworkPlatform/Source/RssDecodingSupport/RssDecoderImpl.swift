import Foundation

// swiftlint:disable cyclomatic_complexity
final class RssDecoderImpl: NSObject {
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    // queue required for xml sync.
    private let queue: DispatchQueue
    
    private var xmlParser: XMLParser!
    private var parsingError: Error?
    private var parseComplete = false
    private var currentPath = URL(string: "/")!
    private var chanel: RssChannel!
    
    init(
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder(),
        queue: DispatchQueue = DispatchQueue(label: "com.muzle.NetworkPlatform-RssDecoderImpl", qos: .utility)
    ) {
        self.encoder = encoder
        self.decoder = decoder
        self.queue = queue
    }
}

// MARK: - Implement RssDecoder

extension RssDecoderImpl: RssDecoder {
    func decode(data: Data) throws -> RssChannel {
        try queue.sync {
            xmlParser = XMLParser(data: data)
            xmlParser.delegate = self
            xmlParser.parse()
            if let error = parsingError { throw error }
            guard let chanel = chanel else { throw RssDecoderError.emtyChanelInResult }
            return chanel
        }
    }
}

// MARK: - Implement XMLParserDelegate

extension RssDecoderImpl: XMLParserDelegate {
    func parser(
        _ parser: XMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String: String]
    ) {
        currentPath = currentPath.appendingPathComponent(elementName)
        set(attributes: attributeDict)
    }
    
    func parser(
        _ parser: XMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?
    ) {
        currentPath = currentPath.deletingLastPathComponent()
        if currentPath.absoluteString == "/" {
            parseComplete = true
            xmlParser.abortParsing()
        }
    }
    
    func parser(
        _ parser: XMLParser,
        foundCDATA CDATABlock: Data
    ) {
        guard let string = String(data: CDATABlock, encoding: .utf8) else {
            xmlParser.abortParsing()
            parsingError = RssDecoderError.foundCDATA(path: currentPath.absoluteString)
            return
        }
        set(value: string)
    }
    
    func parser(
        _ parser: XMLParser,
        foundCharacters string: String
    ) {
        set(value: string)
    }
    
    func parser(
        _ parser: XMLParser,
        parseErrorOccurred parseError: Error
    ) {
        guard !parseComplete, parsingError == nil else { return }
        parsingError = parseError
    }
}

// MARK: - Helpers

extension RssDecoderImpl {
    private func set(value: String) {
        guard
            let path = RssPath(rawValue: currentPath.absoluteString),
                (chanel != nil || path == .chanel)
        else { return }
        switch path {
        case .chanel:
            chanel = RssChannel()
        case .chanelDescription:
            chanel.description = chanel.description?.appending(value) ?? value
        case .chanelLanguage:
            chanel.language = chanel.language?.appending(value) ?? value
        case .chanelLink:
            chanel.link = chanel.link?.appending(value) ?? value
        case .chanelTitle:
            chanel.title = chanel.title?.appending(value) ?? value
        case .chanelTtl:
            chanel.ttl = Int(value)
        case .chanelPubDate:
            chanel.pubDate = value
        case .chanelImage:
            chanel.image = RssChanelImage()
        case .chanelImageTitle:
            chanel.image?.title = chanel.image?.title?.appending(value) ?? value
        case .chanelImageUrl:
            chanel.image?.url = chanel.image?.title?.appending(value) ?? value
        case .chanelImageLink:
            chanel.image?.link = chanel.image?.link?.appending(value) ?? value
        case .chanelImageHeight:
            chanel.image?.height = Int(value)
        case .chanelImageWidth:
            chanel.image?.width = Int(value)
        case .chanelItem:
            chanel.items.append(RssPost())
        case .chanelItemLink:
            chanel.items.last?.link = chanel.items.last?.link?.appending(value) ?? value
        case .chanelItemAuthor:
            chanel.items.last?.author = chanel.items.last?.author?.appending(value) ?? value
        case .chanelItemTitle:
            chanel.items.last?.title = chanel.items.last?.title?.appending(value) ?? value
        case .chanelItemPubDate:
            chanel.items.last?.pubDate = chanel.items.last?.pubDate?.appending(value) ?? value
        case .chanelItemDescription:
            chanel.items.last?.description = chanel.items.last?.description?.appending(value) ?? value
        case .chanelItemEnclosure:
            break
        case .chanelItemGuid:
            chanel.items.last?.guid = chanel.items.last?.guid?.appending(value) ?? value
        case .chanelItemCategory:
            chanel.items.last?.category = chanel.items.last?.category?.appending(value) ?? value
        }
    }
    
    private func set(attributes: [String: String]) {
        guard
            let path = RssPath(rawValue: currentPath.absoluteString),
            path == .chanelItemEnclosure,
            !attributes.isEmpty
        else { return }
        do {
            let model: RssEnclosure = try decode(
                attributes: attributes,
                encoder: encoder,
                decoder: decoder
            )
            chanel.items.last?.enclosure = model
        } catch {
            self.parsingError = error
        }
    }
    
    private func decode<T: Decodable>(
        attributes: [String: String],
        encoder: JSONEncoder,
        decoder: JSONDecoder
    ) throws -> T {
        let data = try encoder.encode(attributes)
        return try decoder.decode(T.self, from: data)
    }
}
// swiftlint:enable cyclomatic_complexity
