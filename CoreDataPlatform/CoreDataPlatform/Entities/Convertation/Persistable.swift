import Foundation
import CoreData

protocol Persistable: NSFetchRequestResult, DomainConvertible {
    static var entityName: String { get }
    static func fetchRequest() -> NSFetchRequest<Self>
    static func fetchRequestResult() -> NSFetchRequest<NSFetchRequestResult>
    
    static var primaryKey: String { get }
}

extension Persistable {
    static var entityName: String {
        String(describing: self)
    }
    
    static func fetchRequest() -> NSFetchRequest<Self> {
        NSFetchRequest(entityName: entityName)
    }
    
    static func fetchRequestResult() -> NSFetchRequest<NSFetchRequestResult> {
        NSFetchRequest(entityName: entityName)
    }
    
    static var primaryKey: String { "id" }
}
