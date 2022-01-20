import XCTest
@testable import CoreDataPlatform
import Domain
import RxBlocking

class DAOTests: XCTestCase {
    var dao: DAOImpl<Post>!
    
    override func setUpWithError() throws {
        dao = .init(context: DBLoader().context)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        dao = nil
        try super.tearDownWithError()
    }

    func testDao() throws {
        XCTAssertNoThrow(try XCTUnwrap(try dao.deleteAll().toBlocking().first()))
        XCTAssert(try XCTUnwrap(try dao.query(with: nil, sortDescriptors: []).toBlocking().first()).isEmpty)
        let post = Post(id_: "1", sourceId_: "1", sourceName_: "1")
        XCTAssertEqual(try XCTUnwrap(try dao.saveOrUpdate(entity: post).toBlocking().first()), post)
        XCTAssertEqual(try XCTUnwrap(try dao.query(with: nil, sortDescriptors: []).toBlocking().first()), [post])
        
        let post1 = Post(id_: "1", title_: "title", sourceId_: "1", sourceName_: "1")
        XCTAssertEqual(try XCTUnwrap(try dao.saveOrUpdate(entity: post1).toBlocking().first()), post1)
        XCTAssertEqual(try XCTUnwrap(try dao.query(with: nil, sortDescriptors: []).toBlocking().first()), [post1])
        
        let post2 = Post(id_: "2", title_: "title", sourceId_: "2", sourceName_: "2")
        XCTAssertEqual(try XCTUnwrap(try dao.saveOrUpdate(entity: post2).toBlocking().first()), post2)
        XCTAssertEqual(try XCTUnwrap(try dao.query(with: nil, sortDescriptors: [.init(key: "id", ascending: true)]).toBlocking().first()), [post1, post2])
        XCTAssertEqual(try XCTUnwrap(try dao.query(with: nil, sortDescriptors: [.init(key: "id", ascending: false)]).toBlocking().first()), [post2, post1])
        XCTAssertEqual(try XCTUnwrap(try dao.query(with: .init(format: "id==1"), sortDescriptors: []).toBlocking().first()), [post1])
        
        XCTAssertNoThrow(try XCTUnwrap(try dao.deleteAll().toBlocking().first()))
        XCTAssert(try XCTUnwrap(try dao.query(with: nil, sortDescriptors: []).toBlocking().first()).isEmpty)
    }
}
