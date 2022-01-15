import Foundation
import Domain
import CoreData
import RxSwift

extension CDPost: DomainConvertible {
    func asDomain() -> Post {
        Post(
            id_: id.unsafelyUnwrapped,
            author_: author?.asDomain(),
            link_: link,
            publicationDate_: publicationDate,
            title_: title,
            description_: postDescription,
            category_: category,
            image_: image?.asDomain()
        )
    }
}

extension CDPost: Persistable {
    
}

extension Post: CoreDataRepresentable {
    var uid: String {
        id
    }
    
    func sync(in context: NSManagedObjectContext) -> Single<CDPost> {
        let selfSync = context.rx.sync(entity: self, update: update(entity:))
        let authorSync = author?.sync(in: context).map(CDAuthor?.init) ?? .just(nil)
        let imageSync = image?.sync(in: context).map(CDImage?.init) ?? .just(nil)
        return Single
            .zip(selfSync, authorSync, imageSync) { post, author, image -> CDPost in
                post.author = author
                post.image = image
                return post
            }
    }
    
    func update(entity: CDPost) {
        entity.id = id
        entity.link = link
        entity.publicationDate = publicationDate
        entity.title = title
        entity.postDescription = description
        entity.category = category
    }
}
