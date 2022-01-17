import Foundation
import CoreData
import RxSwift

final class DAOImpl<Entity: CoreDataRepresentable>: DAO where Entity == Entity.CoreDataType.DomainType {
    private let context: NSManagedObjectContext
    
    init(
        context: NSManagedObjectContext
    ) {
        self.context = context
    }
    
    func query(
        with predicate: NSPredicate?,
        sortDescriptors: [NSSortDescriptor] = []
    ) -> Observable<[Entity]> {
        let request = Entity.CoreDataType.fetchRequest()
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return context.rx.entities(fetchRequest: request).mapToDomain()
    }
    
    func saveOrUpdate(entities: [Entity]) -> Single<Void> {
        Single
            .zip(entities.map { $0.sync(in: context) })
            .map { _ in }
            .flatMap(context.rx.save)
    }
    
    func saveOrUpdate(entity: Entity) -> Single<Entity> {
        entity.sync(in: context)
            .map { $0.asDomain() }
            .flatMap { [context] post in context.rx.save().map { _ in post } }
    }
    
    func delete(entity: Entity) -> Single<Void> {
        entity.sync(in: context)
            .compactMap { $0 as? NSManagedObject }
            .asObservable()
            .flatMap(context.rx.delete)
            .take(1)
            .asSingle()
    }
    
    func deleteAll() -> Single<Void> {
        context.rx.deleteAll(request: Entity.CoreDataType.fetchRequestResult())
    }
}
