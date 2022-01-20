import XCTest
@testable import NetworkPlatform

class SHAServiceTests: XCTestCase {
    
    var shaService: SHAService!
    var encoder: JSONEncoder!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        shaService = SHA256()
        encoder = JSONEncoder()
    }
    
    override func tearDownWithError() throws {
        shaService = nil
        encoder = nil
        try super.tearDownWithError()
    }
    
    func testSha() throws {
        let text = "Super text"
        let textData = try XCTUnwrap(text.data(using: .utf8))
        let expected = "f461d3a3288ad9129ab3a0bd1ea5bfd70e67cdc7bcc008dcb0063656ee5a224a"
        XCTAssertEqual(try shaService.sha(for: textData), expected)
    }
}
