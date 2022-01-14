import Foundation

internal struct Post: RealmRepresentable, Equatable {
    let uid: String
    let authorName: String?
    let authorEmail: String?
    let link: String?
    let publicationDate: Date?
    let title: String?
    let postDescription: String?
    let category: String?
    let imageUrl: String?
    
    func asRealm() -> RMPost {
        let object = RMPost()
        object.uid = uid
        object.authorName = authorName
        object.authorEmail = authorEmail
        object.link = link
        object.publicationDate = publicationDate
        object.title = title
        object.postDescription = postDescription
        object.category = category
        object.imageUrl = imageUrl
        return object
    }
}
