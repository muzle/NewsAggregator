import XCTest
@testable import RealmPlatform
import RxTest
import RxBlocking
import RxSwift
import Realm
import RealmSwift

fileprivate enum RmConfigs {
    static let testConfig = Realm.Configuration(
        readOnly: false,
        schemaVersion: 1,
        migrationBlock: .none,
        deleteRealmIfMigrationNeeded: true,
        objectTypes: [
            RMTestEntity.self
        ]
    )
}

class PostsDaoTests: XCTestCase {
    var dao: DAOImpl<TestEntity>!
    var sheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        dao = .init(configuration: RmConfigs.testConfig)
        sheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        self.dao = nil
        sheduler = nil
        disposeBag = nil
        try super.tearDownWithError()
    }
    
    func testDao() throws {
        try dao.deleteAll().toBlocking().first()
        XCTAssertTrue(try XCTUnwrap(try dao.entities().toBlocking().first()).isEmpty)
        
        let entites = sheduler.createObserver([TestEntity].self)
        
        let testObjects = (0...3).map(String.init).map(TestEntity.init(id:))
        
        dao.entities()
            .subscribe(entites)
            .disposed(by: disposeBag)
        
        sheduler
            .createColdObservable(
                [
                    .next(10, testObjects[0]),
                    .next(20, testObjects[1]),
                    .next(30, testObjects[2])
                ]
            )
            .flatMap(dao.saveOrUpdate(entity:))
            .subscribe()
            .disposed(by: disposeBag)
        
        sheduler.start()
        
        XCTAssertEqual(
            entites.events,
                [
                    .next(0, [TestEntity]()),
                    .next(10, [testObjects[0]]),
                    .next(20, [testObjects[0], testObjects[1]]),
                    .next(30, [testObjects[0], testObjects[1], testObjects[2]])
                ]
        )
    }
}

struct TestEntity: Equatable, RealmRepresentable {
    let id: String
    
    func asRealm() -> RMTestEntity {
        let obj = RMTestEntity()
        obj.id = id
        return obj
    }
}

final class RMTestEntity: Object, CommonRepresentable {
    @objc dynamic var id: String = ""
    
    func asCommon() -> TestEntity {
        TestEntity(id: id)
    }
    
    override class func primaryKey() -> String? {
        "id"
    }
}
