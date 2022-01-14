import Foundation

protocol DateToStringConverter {
    func convert(_ date: Date, with format: String) -> String
}

// MARK: - DateToStringConverter default implementation

extension DateToStringConverter {
    func convert(_ date: Date, commonDateFormat: CommonDateFormat) -> String {
        convert(date, with: commonDateFormat.rawValue)
    }
    
    func convert(_ date: Date?, commonDateFormat: CommonDateFormat) -> String? {
        guard let date = date else { return nil }
        return convert(date, with: commonDateFormat.rawValue)
    }
}

final class DateToStringConverterImpl: DateToStringConverter {
    private let dateFormatter: DateFormatter
    private let queue = DispatchQueue(label: "com.muzle.NewsAggregator-DateToStringConverterImpl", qos: .utility)
    
    init() {
        dateFormatter = DateFormatter()
    }
    
    func convert(_ date: Date, with format: String) -> String {
        queue.sync {
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: date)
        }
    }
}
