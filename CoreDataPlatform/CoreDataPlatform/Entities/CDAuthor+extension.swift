import Foundation
import Domain

extension CDAuthor: DomainConvertible {
    func asDomain() -> Domain.Author {
        Author(
            name_: name,
            email_: email
        )
    }
}

extension CDAuthor: Persistable {
    
}

extension Author: CoreDataRepresentable {
    var uid: String {
        ""
    }
    
    func update(entity: CDAuthor) {
        entity.name = name
        entity.email = email
    }
}
