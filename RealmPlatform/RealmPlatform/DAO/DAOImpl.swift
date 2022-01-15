import Foundation
import RxSwift
import RealmSwift
import RxRealm

final class DAOImpl<Entity: RealmRepresentable>: DAO where Entity == Entity.RealmType.CommonType, Entity.RealmType: Object {
    typealias CommonEntity = Entity
    typealias StorageEntity = Entity.RealmType
    private let realm: Realm
    
    init(
        configuration: Realm.Configuration
    ) {
        do {
            realm = try Realm(configuration: configuration)
        } catch {
            preconditionFailure(error.localizedDescription)
        }
    }
    
    func entities() -> Observable<[Entity]> {
        let objects = realm.objects(Entity.RealmType.self)
        return Observable.array(from: objects).mapToCommon()
    }
    
    func query(
        with predicate: NSPredicate,
        sortDescriptors: [NSSortDescriptor] = []
    ) -> Observable<[Entity]> {
        let descriptors = sortDescriptors.compactMap(makeRealmSortDescriptor(from:))
        let objects = realm.objects(Entity.RealmType.self)
            .filter(predicate)
            .sorted(by: descriptors)
            
        return Observable.array(from: objects)
            .mapToCommon()
    }
    
    func saveOrUpdate(entity: Entity) -> Single<Entity> {
        Single.create { [realm, entity] observer in
            do {
                try realm.write {
                    realm.add(entity.asRealm(), update: .modified)
                }
                observer(.success(entity))
            } catch {
                observer(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    func delete(entity: Entity) -> Single<Entity> {
        Single.create { [realm, entity] observer in
            do {
                try realm.write {
                    realm.delete(entity.asRealm())
                }
                observer(.success(entity))
            } catch {
                observer(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    func deleteAll() -> Single<Void> {
        Single.create { [realm] observer in
            do {
                try realm.write {
                    realm.deleteAll()
                }
                observer(.success(()))
            } catch {
                observer(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    private func makeRealmSortDescriptor(from descriptor: NSSortDescriptor) -> RealmSwift.SortDescriptor? {
        guard let keyPath = descriptor.key else { return nil }
        return SortDescriptor.init(keyPath: keyPath, ascending: descriptor.ascending)
    }
}
