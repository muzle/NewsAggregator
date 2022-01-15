import Foundation
import Domain

extension CDAuthor: DomainConvertible {
    func asDomain() -> Domain.Author {
        Author(name_: name, email_: email)
    }
}
