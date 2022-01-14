import XCTest
@testable import NewsAggregator

class DateToStringConverterTests: XCTestCase {

    var dateToStringConverter: DateToStringConverter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        dateToStringConverter = DateToStringConverterImpl()
    }

    override func tearDownWithError() throws {
        dateToStringConverter = nil
        try super.tearDownWithError()
    }

    func testConverter() throws {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        XCTAssertEqual(formatter.string(from: date), dateToStringConverter.convert(date, with: formatter.dateFormat))
    }
}
