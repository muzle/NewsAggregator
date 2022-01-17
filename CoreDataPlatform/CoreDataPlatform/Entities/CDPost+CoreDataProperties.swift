import Foundation
import CoreData

extension CDPost {

    @nonobjc class func fetchRequest() -> NSFetchRequest<CDPost> {
        return NSFetchRequest<CDPost>(entityName: "CDPost").apply {
            $0.sortDescriptors = [NSSortDescriptor(key: "publicationDate", ascending: false)]
        }
    }

    @NSManaged var id: String
    @NSManaged var link: URL?
    @NSManaged var publicationDate: Date?
    @NSManaged var title: String?
    @NSManaged var postDescription: String?
    @NSManaged var category: String?
    @NSManaged var sourceId: String
    @NSManaged var sourceName: String
    @NSManaged var sourceLink: URL?
    @NSManaged var authorName: String?
    @NSManaged var authorEmail: String?
    @NSManaged var imageURL: URL?
}
