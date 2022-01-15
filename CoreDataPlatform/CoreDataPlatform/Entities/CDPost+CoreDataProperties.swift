import Foundation
import CoreData

extension CDPost {

    @nonobjc class func fetchRequest() -> NSFetchRequest<CDPost> {
        return NSFetchRequest<CDPost>(entityName: "CDPost").apply {
            $0.sortDescriptors = [NSSortDescriptor(key: "publicationDate", ascending: true)]
        }
    }

    @NSManaged var id: String?
    @NSManaged var link: URL?
    @NSManaged var publicationDate: Date?
    @NSManaged var title: String?
    @NSManaged var postDescription: String?
    @NSManaged var category: String?
    @NSManaged var author: CDAuthor?
    @NSManaged var image: CDImage?
}
