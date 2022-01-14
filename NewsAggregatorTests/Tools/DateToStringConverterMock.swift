import Foundation
@testable import NewsAggregator

final class DateToStringConverterMock: DateToStringConverter {
    private let result: String
    init(result: String) {
        self.result = result
    }
    
    func convert(_ date: Date, with format: String) -> String {
        return result
    }
}
