import Foundation
import RxSwift

internal protocol DAO {
    associatedtype Entity
    
    func query(
        with predicate: NSPredicate?,
        sortDescriptors: [NSSortDescriptor]
    ) -> Observable<[Entity]>
    
    func saveOrUpdate(entities: [Entity]) -> Single<Void>
    func saveOrUpdate(entity: Entity) -> Single<Entity>
    
    func delete(entity: Entity) -> Single<Void>
    
    func deleteAll() -> Single<Void>
}
