import Foundation
import Domain

extension CDImage: DomainConvertible {
    func asDomain() -> Domain.Image {
        Image(url_: url)
    }
}

extension CDImage: Persistable {
    
}

extension Image: CoreDataRepresentable {
    var uid: String {
        ""
    }
    
    func update(entity: CDImage) {
        entity.url = url
    }
}
