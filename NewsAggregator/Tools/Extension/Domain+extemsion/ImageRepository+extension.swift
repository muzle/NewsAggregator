import Foundation
import Domain
import RxSwift

extension ImageRepository {
    func image(with url: URL?) -> Single<UIImage> {
        guard let url = url else { return .error(URLError(.badURL)) }
        return image(with: url)
    }
}
