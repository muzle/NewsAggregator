import Foundation
import CoreData

extension CDAuthor {

    @nonobjc class func fetchRequest() -> NSFetchRequest<CDAuthor> {
        return NSFetchRequest<CDAuthor>(entityName: "CDAuthor")
    }

    @NSManaged var name: String?
    @NSManaged var email: String?
}
