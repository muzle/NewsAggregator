import Foundation
import CoreData
import RxSwift

protocol CoreDataRepresentable {
    associatedtype CoreDataType: Persistable
    
    var uid: String { get }
    
    func update(entity: CoreDataType)
    
    func sync(in context: NSManagedObjectContext) -> Single<CoreDataType>
}

extension CoreDataRepresentable {
    func sync(in context: NSManagedObjectContext) -> Single<CoreDataType> {
        context.rx.sync(entity: self, update: update)
    }
}
