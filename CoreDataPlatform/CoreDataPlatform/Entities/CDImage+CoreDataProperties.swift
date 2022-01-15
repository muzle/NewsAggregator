import Foundation
import CoreData

extension CDImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDImage> {
        return NSFetchRequest<CDImage>(entityName: "CDImage")
    }

    @NSManaged public var url: URL?
}
