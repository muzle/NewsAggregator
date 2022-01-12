import Foundation
import Domain

internal struct NAPost: Codable, Equatable {
    let source: NASource?
    let author, title, description, content: String?
    let url, urlToImage: URL?
    let publishedAt: Date?
    
    func asDomaim() -> Post {
        var image: Image?
        if let urlToImage = urlToImage {
            image = .init(url_: urlToImage)
        }
        
        return Post(
            id_: "",
            author_: nil,
            link_: url,
            publicationDate_: publishedAt,
            title_: title,
            description_: description,
            category_: nil,
            image_: image,
            source_: nil
        )
    }
}
