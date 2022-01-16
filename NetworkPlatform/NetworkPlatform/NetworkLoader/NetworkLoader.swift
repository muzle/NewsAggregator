import Foundation
import RxSwift
import Domain

// swiftlint:disable function_parameter_count, identifier_name
internal protocol NetworkLoader: ReactiveCompatible {
    func loadData(
        _ request: URLRequest,
        session: URLSession,
        completionQueue: DispatchQueue,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> Domain.Cancelable
    
    func load(
        _ request: URLRequest,
        session: URLSession,
        completionQueue: DispatchQueue,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Domain.Cancelable
    
    func load<T: Decodable>(
        _ request: URLRequest,
        type: T.Type,
        session: URLSession,
        decoder: JSONDecoder,
        completionQueue: DispatchQueue,
        decodingQueue: DispatchQueue?,
        completion: @escaping (Result<T, Error>) -> Void
    ) -> Domain.Cancelable
}

// MARK: - NetworkLoader + default implementation

extension NetworkLoader {
    func load<T: Decodable>(
        _ request: URLRequest,
        type: T.Type,
        session: URLSession,
        decoder: JSONDecoder,
        completionQueue: DispatchQueue,
        decodingQueue: DispatchQueue?,
        completion: @escaping (Result<T, Error>) -> Void
    ) -> Domain.Cancelable {
        loadData(
            request,
            session: session,
            completionQueue: completionQueue
        ) { r in
            let result = r.flatMap { data -> Result<T, Error> in
                do {
                    let model = try decoder.decode(T.self, from: data)
                    return .success(model)
                } catch {
                    return .failure(error)
                }
            }
            completion(result)
        }
    }
}

// MARK: - Reactive + NetworkLoader

extension Reactive where Base: NetworkLoader {
    func load<T: Decodable>(
        _ request: URLRequest,
        type: T.Type,
        session: URLSession = URLSession.shared,
        decoder: JSONDecoder = JSONDecoderFactory.commomDecoder,
        completionQueue: DispatchQueue = .main,
        decodingQueue: DispatchQueue? = nil
    ) -> Single<T> {
        Single.create { observer in
            let cancelable = base.load(
                request,
                type: type.self,
                session: session,
                decoder: decoder,
                completionQueue: completionQueue,
                decodingQueue: decodingQueue
            ) { result in
                switch result {
                case .success(let result):
                    observer(.success(result))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            
            return Disposables.create {
                cancelable.cancel()
            }
        }
    }
    
    func loadData(
        _ request: URLRequest,
        session: URLSession,
        completionQueue: DispatchQueue
    ) -> Single<Data> {
        Single.create { obsever in
            let cancelable = base.loadData(
                request,
                session: .shared,
                completionQueue: .main) { result in
                    switch result {
                    case .success(let data):
                        obsever(.success(data))
                    case .failure(let error):
                        obsever(.failure(error))
                    }
                }
            return Disposables.create {
                cancelable.cancel()
            }
        }
    }
    
    func load(
        _ request: URLRequest,
        session: URLSession = URLSession.shared,
        completionQueue: DispatchQueue = .main
    ) -> Single<Void> {
        Single.create { observer in
            let cancelable = base.load(
                request,
                session: session,
                completionQueue: completionQueue
            ) { result in
                switch result {
                case .success(let result):
                    observer(.success(result))
                case .failure(let error):
                    observer(.failure(error))
                }
            }
            
            return Disposables.create {
                cancelable.cancel()
            }
        }
    }
}
// swiftlint:enable function_parameter_count, identifier_name
