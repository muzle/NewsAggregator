import XCTest
@testable import RealmPlatform
import RxTest
import RxBlocking
import RxSwift

class PostsDaoTests: XCTestCase {
    var dao: DAOImpl<Post>!
    var models: [Post] = []
    var sheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        dao = try .init(
            configuration: RealmConfigurationFactory.makePostsConfiguration()
        )
        sheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        self.dao = nil
        self.models = []
        sheduler = nil
        disposeBag = nil
        try super.tearDownWithError()
    }
    
    func testDao() throws {
        try dao.deleteAll().toBlocking().first()
        XCTAssertTrue(try XCTUnwrap(try dao.entities().toBlocking().first()).isEmpty)
        
        let posts = sheduler.createObserver([Post].self)
        dao.entities()
            .subscribe(posts)
            .disposed(by: disposeBag)
        
        sheduler
            .createColdObservable(
                [
                    .next(5, makePostStub())
                ]
            )
            .flatMap(dao.saveOrUpdate(entity:))
            .subscribe()
            .disposed(by: disposeBag)
        
        sheduler.start()
        
        XCTAssertEqual(
            posts.events,
            [
                .next(0, [Post]()),
                .next(5, [makePostStub()])
            ]
        )
    }
    
    func makePostStub() -> Post {
        Post(
            uid: "8",
            authorName: nil,
            authorEmail: nil,
            link: nil,
            publicationDate: nil,
            title: nil,
            postDescription: nil,
            category: nil,
            imageUrl: nil
        )
    }
}
