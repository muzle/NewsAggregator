// https://github.com/sergdort/CleanArchitectureRxSwift/blob/master/CoreDataPlatform/RxCoreData/FetchedResultsControllerEntityObserver.swift
import Foundation
import CoreData
import RxSwift

final class FetchedResultsControllerEntityObserver<T: NSFetchRequestResult>: NSObject, NSFetchedResultsControllerDelegate {
    typealias Observer = AnyObserver<[T]>
    fileprivate let observer: Observer
    fileprivate let disposeBag = DisposeBag()
    fileprivate let frc: NSFetchedResultsController<T>
    
    init(
        observer: Observer,
        fetchRequest: NSFetchRequest<T>,
        managedObjectContext context: NSManagedObjectContext,
        sectionNameKeyPath: String?,
        cacheName: String?
    ) {
        self.observer = observer
        self.frc = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: sectionNameKeyPath,
            cacheName: cacheName
        )
        super.init()
        
        context.perform { [self] in
            frc.delegate = self
            do {
                try frc.performFetch()
            } catch let e {
                observer.on(.error(e))
            }
            sendNextElement()
        }
    }
    
    fileprivate func sendNextElement() {
        frc.managedObjectContext.perform { [self] in
            let entities = frc.fetchedObjects ?? []
            observer.on(.next(entities))
        }
    }
    
    public func controllerDidChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>
    ) {
        sendNextElement()
    }
}

// MARK: - Implement Disposable

extension FetchedResultsControllerEntityObserver: Disposable {
    func dispose() {
        frc.delegate = nil
    }
}
