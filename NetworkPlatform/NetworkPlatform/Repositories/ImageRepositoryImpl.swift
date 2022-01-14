import Foundation
import Domain
import SDWebImage
import RxSwift

final class ImageRepositoryImpl: Domain.ImageRepository {
    private let imageManager: SDWebImageManager
    
    init(imageManager: SDWebImageManager = SDWebImageManager()) {
        self.imageManager = imageManager
    }
    
    func image(with url: URL) -> Single<UIImage> {
        Single.create { [imageManager] observer in
            let cancelable = imageManager.loadImage(
                with: url,
                progress: .none) { image, _, error, _, _, _ in
                    if let error = error {
                        observer(.failure(error))
                    } else if let image = image {
                        observer(.success(image))
                    } else {
                        observer(.failure(ImageRepositoryImplError.loadImage))
                    }
                }
            return Disposables.create {
                cancelable?.cancel()
            }
        }
    }
    
    enum ImageRepositoryImplError: Error {
        case loadImage
    }
}
