import Foundation
import CoreData

extension NSManagedObjectContext {
    func create<T: NSFetchRequestResult>() -> T {
        guard let entity = NSEntityDescription
                .insertNewObject(
                    forEntityName: String(describing: T.self),
                    into: self
                ) as? T
        else {
            preconditionFailure("Invalid Entity with name: \(String(describing: T.self))")
        }
        return entity
    }
}
