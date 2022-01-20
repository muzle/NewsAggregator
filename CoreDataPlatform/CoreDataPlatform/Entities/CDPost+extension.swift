import Foundation
import Domain
import CoreData
import RxSwift

extension CDPost: DomainConvertible {
    func asDomain() -> Post {
        Post(
            id_: id,
            author_: authorName == nil && authorEmail == nil ? nil : Author(name_: authorName, email_: authorEmail),
            link_: link,
            publicationDate_: publicationDate,
            title_: title,
            description_: postDescription,
            category_: category,
            image_: imageURL == nil ? nil : Image(url_: imageURL),
            sourceId_: sourceId,
            sourceName_: sourceName,
            sourceLink_: sourceLink
        )
    }
}

extension CDPost: Persistable {
    
}

extension Post: CoreDataRepresentable {
    var uid: String {
        id
    }
    
    func update(entity: CDPost) {
        entity.id = id
        entity.link = link
        entity.publicationDate = publicationDate
        entity.title = title
        entity.postDescription = description
        entity.category = category
        entity.sourceId = sourceId
        entity.sourceLink = sourceLink
        entity.sourceName = sourceName
        entity.imageURL = image?.url
        entity.authorName = author?.name
        entity.authorEmail = author?.email
    }
}
