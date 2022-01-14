import UIKit
import RxSwift

public protocol ImageRepository {
    func image(with url: URL) -> Single<UIImage>
}
