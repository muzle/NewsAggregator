import Foundation
import RxSwift

internal protocol DAO {
    associatedtype CommonEntity
    func entities() -> Observable<[CommonEntity]>
    
    func query(
        with predicate: NSPredicate,
        sortDescptors: [NSSortDescriptor]
    ) -> Observable<[CommonEntity]>
    
    func saveOrUpdate(entity: CommonEntity) -> Single<CommonEntity>
    
    func delete(entity: CommonEntity) -> Single<CommonEntity>
    
    func deleteAll() -> Single<Void>
}
