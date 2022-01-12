import Foundation
import RxSwift
import ApiRouter

internal class RootRepository<Loader: NetworkLoader> {
    private let loader: Loader
    
    init(loader: Loader) {
        self.loader = loader
    }
    
    func load<T: Decodable>(
        requestConvertible: URLRequestConvertible,
        encoder: JSONEncoder = JSONEncoderFactory.commomEncoder,
        decoder: JSONDecoder = JSONDecoderFactory.commomDecoder
    ) -> Single<T> {
        do {
            let request = try requestConvertible.convertToURLRequest(with: encoder)
            return loader.rx.load(
                request,
                type: T.self,
                session: .shared,
                decoder: decoder,
                completionQueue: .main,
                decodingQueue: nil
            )
        } catch {
            return .error(error)
        }
    }
}
