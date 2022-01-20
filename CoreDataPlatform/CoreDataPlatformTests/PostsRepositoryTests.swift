import XCTest
@testable import CoreDataPlatform
import Domain
import RxBlocking

class PostsRepositoryTests: XCTestCase {
    var repository: CoreDataPlatform.PostsRepository<DAOImpl<Post>>!
    
    override func setUpWithError() throws {
        let dao = DAOImpl<Post>.init(context: DBLoader().context)
        repository = .init(postsDao: dao)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        repository = nil
        try super.tearDownWithError()
    }

    func testRepository() throws {
        let post = Post(id_: "1", sourceId_: "1", sourceName_: "1")
        XCTAssertNoThrow(try XCTUnwrap(try repository.save(posts: [post]).toBlocking().first()))
        XCTAssertEqual(try XCTUnwrap(try repository.queryPosts(with: nil, sortDescriptors: []).toBlocking().first()), [post])

        let post1 = Post(id_: "1", title_: "title", sourceId_: "1", sourceName_: "1")
        XCTAssertNoThrow(try XCTUnwrap(try repository.save(posts: [post1]).toBlocking().first()))
        XCTAssertEqual(try XCTUnwrap(try repository.queryPosts(with: nil, sortDescriptors: []).toBlocking().first()), [post1])

        let post2 = Post(id_: "2", title_: "title", sourceId_: "2", sourceName_: "2")
        XCTAssertNoThrow(try XCTUnwrap(try repository.save(posts: [post2]).toBlocking().first()))
        XCTAssertEqual(try XCTUnwrap(try repository.queryPosts(with: nil, sortDescriptors: [.init(key: "id", ascending: true)]).toBlocking().first()), [post1, post2])
        XCTAssertEqual(try XCTUnwrap(try repository.queryPosts(with: nil, sortDescriptors: [.init(key: "id", ascending: false)]).toBlocking().first()), [post2, post1])
        XCTAssertEqual(try XCTUnwrap(try repository.queryPosts(with: .init(format: "id==1"), sortDescriptors: []).toBlocking().first()), [post1])
    }
}
