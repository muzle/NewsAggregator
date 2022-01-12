import XCTest
@testable import NetworkPlatform

class NewsApiParsingTest: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testJSONDecoding() throws {
        let data = try readFileData(fileName: "NewsApiResponse")
        let result = try JSONDecoderFactory.dateDecoder.decode(NAPostsContainer.self, from: data)
        XCTAssertEqual(result, NAPostsContainer.makeStubAsInFile())
    }
    
    func testRssDecoding() throws {
        let data = try readFileData(fileName: "LentaResponse", ofType: "xml")
        let decoder = RssDecoderImpl()
        let result = try decoder.decode(data: data)
        XCTAssertEqual(result, RssChannel.makeStubAsInFile())
    }
}
