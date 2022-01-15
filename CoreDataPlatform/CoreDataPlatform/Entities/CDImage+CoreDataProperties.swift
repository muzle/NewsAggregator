import Foundation
import CoreData

extension CDImage {

    @nonobjc class func fetchRequest() -> NSFetchRequest<CDImage> {
        return NSFetchRequest<CDImage>(entityName: "CDImage")
    }

    @NSManaged var url: URL?
}
