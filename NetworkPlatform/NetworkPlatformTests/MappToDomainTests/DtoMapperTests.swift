import XCTest
@testable import NetworkPlatform
import Domain

class DtoMapperTests<T, Mapper: DtoMapper>: XCTestCase where Mapper.Result == T, T: Equatable {
    
    var mapper: Mapper!
    var mappedData: T!
    var result: PostsContainer!
    
    override func tearDownWithError() throws {
        mapper = nil
        mappedData = nil
        result = nil
        try super.tearDownWithError()
    }
    
    func testMapping() {
        XCTAssertEqual(mapper.map(mappedData), result)
    }
}

