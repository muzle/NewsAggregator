import Foundation
import Domain

extension CDImage: DomainConvertible {
    func asDomain() -> Domain.Image {
        Image(url_: url)
    }
}
