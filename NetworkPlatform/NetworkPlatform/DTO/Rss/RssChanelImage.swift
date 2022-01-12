import Foundation

internal final class RssChanelImage: Decodable, AutoEquatable, AutoHashable {
    var url: String?
    var title: String?
    var link: String?
    var width, height: Int?
}
