// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
// swiftlint:disable all
// MARK: - Author
extension Author {
    public init(
        name_: String? = nil,
        email_: String? = nil
    ) {
        self.name = name_
        self.email = email_
    }
}
// MARK: - Image
extension Image {
    public init(
        url_: URL? = nil
    ) {
        self.url = url_
    }
}
// MARK: - Post
extension Post {
    public init(
        id_: String,
        author_: Author? = nil,
        link_: URL? = nil,
        publicationDate_: Date? = nil,
        title_: String? = nil,
        description_: String? = nil,
        category_: String? = nil,
        image_: Image? = nil
    ) {
        self.id = id_
        self.author = author_
        self.link = link_
        self.publicationDate = publicationDate_
        self.title = title_
        self.description = description_
        self.category = category_
        self.image = image_
    }
}
// swiftlint:enable all