import Foundation
import Domain

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
