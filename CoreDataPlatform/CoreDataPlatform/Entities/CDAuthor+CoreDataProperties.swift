import Foundation
import CoreData

extension CDAuthor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAuthor> {
        return NSFetchRequest<CDAuthor>(entityName: "CDAuthor")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
}
