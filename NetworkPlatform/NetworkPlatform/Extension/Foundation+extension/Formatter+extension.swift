import Foundation

internal extension Formatter {
    /// 2021-12-12
    static let yyyyMMdd: DateFormatter = {
        makeCommonFormatter().apply {
            $0.dateFormat = "yyyy-MM-dd"
        }
    }()
    
    /// 2022-01-11T16:11:30Z
    static let yyyyMMddTHHmmssZ: DateFormatter = {
        makeCommonFormatter().apply {
            $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        }
    }()
    
    /// Tue, 11 Jan 2022 19:09:37 +0300
    static let RFC822: DateFormatter = {
        makeCommonFormatter().apply {
            $0.dateFormat = "EE, d MMM yyyy HH:mm:ss Z"
        }
    }()
    
    private static func makeCommonFormatter() -> DateFormatter {
        DateFormatter().apply {
            $0.calendar = Calendar(identifier: .iso8601)
            $0.locale = Locale(identifier: "en_US_POSIX")
            $0.timeZone = TimeZone(secondsFromGMT: 0)
        }
    }
}
