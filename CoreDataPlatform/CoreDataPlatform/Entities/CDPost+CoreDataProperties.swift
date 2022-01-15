import Foundation
import CoreData

extension CDPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPost> {
        return NSFetchRequest<CDPost>(entityName: "CDPost")
    }

    @NSManaged public var id: String?
    @NSManaged public var link: URL?
    @NSManaged public var publicationDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var postDescription: String?
    @NSManaged public var category: String?
    @NSManaged public var author: CDAuthor?
    @NSManaged public var image: CDImage?
}
