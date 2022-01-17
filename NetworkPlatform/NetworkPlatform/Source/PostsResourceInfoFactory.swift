import Foundation
import Domain

internal enum PostsResourceInfoFactory {
    static let lenta = PostsResourceInfo(
        id_: "lenta.ru",
        url_: URL(string: "https://lenta.ru"),
        name_: "Lenta"
    )
    static let gazeta = PostsResourceInfo(
        id_: "gazeta.ru",
        url_: URL(string: "https://gazeta.ru"),
        name_: "Gazeta"
    )
    static let newsApi = PostsResourceInfo(
        id_: "newsapi.com",
        url_: URL(string: "https://newsapi.org"),
        name_: "NewsApi"
    )
}
