import Foundation

internal class RssChanelImage: Decodable, AutoEquatable {
    var url: String?
    var title: String?
    var link: String?
    var width, height: Int?
}
