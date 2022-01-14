import Foundation
import RealmSwift

final class RMPost: Object, CommonRepresentable {
    @objc dynamic var uid: String = ""
    @objc dynamic var authorName: String?
    @objc dynamic var authorEmail: String?
    @objc dynamic var link: String?
    @objc dynamic var publicationDate: Date?
    @objc dynamic var title: String?
    @objc dynamic var postDescription: String?
    @objc dynamic var category: String?
    @objc dynamic var imageUrl: String?
    @objc dynamic var isFavorite: Bool = false
    @objc dynamic var visitCount: Int = 0
    
    func asCommon() -> Post {
        Post(
            uid: uid,
            authorName: authorName,
            authorEmail: authorEmail,
            link: link,
            publicationDate: publicationDate,
            title: title,
            postDescription: postDescription,
            category: category,
            imageUrl: imageUrl
        )
    }
    
    override class func primaryKey() -> String? {
        "uid"
    }
}
