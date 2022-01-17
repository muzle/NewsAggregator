import Foundation
import Domain

internal struct Post: Equatable, RealmRepresentable, DomainRepresentable, AutoSetable {
    let uid: String
    let authorName: String?
    let authorEmail: String?
    let link: String?
    let publicationDate: Date?
    let title: String?
    let postDescription: String?
    let category: String?
    let imageUrl: String?
    var isFavorite: Bool
    var addToFavoriteDate: Date?
    var visitCount: Int
    let sourceId: String
    let sourceName: String
    let sourceURL: String?
    
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
        object.isFavorite = isFavorite
        object.addToFavoriteDate = addToFavoriteDate
        object.visitCount = visitCount
        object.sourceId = sourceId
        object.sourceName = sourceName
        object.sourceURL = sourceURL
        return object
    }
    
    func asDomain() -> Domain.Post {
        Domain.Post(
            id_: uid,
            author_: .init(name_: authorName, email_: authorEmail),
            link_: .init(string: link ?? ""),
            publicationDate_: publicationDate,
            title_: title,
            description_: postDescription,
            category_: category,
            image_: .init(url_: .init(string: imageUrl ?? "")),
            sourceId_: sourceId,
            sourceName_: sourceName,
            sourceLink_: URL(string: sourceURL ?? "")
        )
    }
}
