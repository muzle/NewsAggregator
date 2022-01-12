import Foundation

internal enum JSONDecoderFactory {
    static let commomDecoder = JSONDecoder()
    static let dateDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .customDateDecoding
        return decoder
    }()
}


extension JSONDecoder.DateDecodingStrategy {
    static let customDateDecoding = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        if
            let date = Formatter.yyyyMMdd.date(from: string) ??
                Formatter.yyyyMMddTHHmmssZ.date(from: string) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}
