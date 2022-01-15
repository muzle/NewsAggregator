// https://github.com/sergdort/CleanArchitectureRxSwift/blob/master/CoreDataPlatform/RxCoreData/NSManagedObjectContext%2BRx.swift
import Foundation
import CoreData
import RxSwift

extension Reactive where Base: NSManagedObjectContext {
    func entities<T: NSFetchRequestResult>(
        fetchRequest: NSFetchRequest<T>,
        sectionNameKeyPath: String? = nil,
        cacheName: String? = nil
    ) -> Observable<[T]> {
        Observable.create { observer in
            let observerAdapter = FetchedResultsControllerEntityObserver(
                observer: observer,
                fetchRequest: fetchRequest,
                managedObjectContext: base,
                sectionNameKeyPath: sectionNameKeyPath,
                cacheName: cacheName
            )
            return Disposables.create {
                observerAdapter.dispose()
            }
        }
    }
    
    func save() -> Single<Void> {
        Single.create { observer in
            do {
                try base.save()
                observer(.success(()))
            } catch {
                observer(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    func delete<T: NSManagedObject>(entity: T) -> Single<Void> {
        Single.create { observer in
            base.delete(entity)
            observer(.success(()))
            return Disposables.create()
        }.flatMap(save)
    }
    
    func deleteAll(request: NSFetchRequest<NSFetchRequestResult>) -> Single<Void> {
        Single.create { observer in
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            do {
                try base.execute(deleteRequest)
                observer(.success(()))
            } catch {
                observer(.failure(error))
            }
            return Disposables.create()
        }.flatMap(save)
    }
    
    func first<T: NSFetchRequestResult>(
        ofType: T.Type = T.self,
        with predicate: NSPredicate
    ) -> Single<T?> {
        Single.deferred {
            let entityName = String(describing: T.self)
            let request = NSFetchRequest<T>(entityName: entityName)
            request.predicate = predicate
            do {
                let result = try base.fetch(request).first
                return .just(result)
            } catch {
                return .error(error)
            }
        }
    }
    
    func sync<C: CoreDataRepresentable, P>(
        entity: C,
        update: @escaping (P) -> Void
    ) -> Single<P> where C.CoreDataType == P {
        let predicate = NSPredicate(format: "\(P.primaryKey) == %@", entity.uid)
        return first(ofType: P.self, with: predicate)
            .flatMap { obj -> Single<P> in
                let object = obj ?? base.create()
                update(object)
                return .just(object)
            }
    }
    
    func sync<C: CoreDataRepresentable, P>(
        entities: [C]
    ) -> Single<Void> where C.CoreDataType == P {
        Single.create { observer in
            for entity in entities {
                let predicate = NSPredicate(format: "\(P.primaryKey) == %@", entity.uid)
                let request = C.CoreDataType.fetchRequest()
                request.predicate = predicate
                do {
                    let object = try base.fetch(request).first ?? base.create()
                    entity.update(entity: object)
                } catch {
                    observer(.failure(error))
                }
                observer(.success(()))
            }
            return Disposables.create()
        }
    }
}
