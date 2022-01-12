import XCTest
@testable import NetworkPlatform

class RoutingTests: XCTestCase {
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testLentaPostsRoute() throws {
        let url = try LentaRuRouter.posts.convertToURL(with: JSONEncoderFactory.commomEncoder)
        let result = "https://lenta.ru/rss"
        XCTAssertEqual(url.absoluteString, result)
        
        let request = try LentaRuRouter.posts.convertToURLRequest(with: JSONEncoderFactory.commomEncoder)
        XCTAssertEqual(request.url!.absoluteString, result)
        XCTAssertEqual(request.httpMethod, "GET")
    }
    
    func testGazetaPostsRoute() throws {
        let url = try GazetaRuRouter.posts.convertToURL(with: JSONEncoderFactory.commomEncoder)
        let result = "https://gazeta.ru/export/rss/lenta.xml"
        XCTAssertEqual(url.absoluteString, result)
        
        let request = try GazetaRuRouter.posts.convertToURLRequest(with: JSONEncoderFactory.commomEncoder)
        XCTAssertEqual(request.url!.absoluteString, result)
        XCTAssertEqual(request.httpMethod, "GET")
    }
    
    func testNewsApiPostsRoute() throws {
        let date = Date()
        let query = NAPostsQuery(
            token: "token",
            query: "query",
            from: date,
            sort: .pubDate
        )
        let dateText = Formatter.yyyyMMdd.string(from: date)
        let url = try NewsApiRouter.posts(query: query)
            .convertToURL(with: JSONEncoderFactory.yyyyMMddDateSupportEncoder)
        let result = "https://newsapi.org?q=\(query.query!)&from=\(dateText)&apiKey=\(query.token)&sortBy=\(query.sort!.rawValue)"
        XCTAssertEqual(url.absoluteString, result)
        
        let request = try NewsApiRouter.posts(query: query).convertToURLRequest(with: JSONEncoderFactory.yyyyMMddDateSupportEncoder)
        XCTAssertEqual(request.url!.absoluteString, result)
        XCTAssertEqual(request.httpMethod, "GET")
    }
}
