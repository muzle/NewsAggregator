import Foundation

enum JSONEncoderFactory {
    static let commomEncoder = JSONEncoder()
    static let yyyyMMddDateSupportEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .yyyyMMdd
        return encoder
    }()
}

extension JSONEncoder.DateEncodingStrategy {
    static let yyyyMMdd = custom { date, encoder in
        var container = encoder.singleValueContainer()
        let text = Formatter.yyyyMMdd.string(from: date)
        try container.encode(text)
    }
}
