import Foundation
import RxSwift
import Domain

internal protocol NetworkLoader: ReactiveCompatible {
    func load(
        _ request: URLRequest,
        session: URLSession,
        decoder: JSONDecoder,
        completionQueue: DispatchQueue,
        decodingQueue: DispatchQueue?,
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
        load(
            request,
            session: session,
            decoder: decoder,
            completionQueue: completionQueue,
            decodingQueue: decodingQueue
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
    
    func load(
        _ request: URLRequest,
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoderFactory.commomDecoder,
        completionQueue: DispatchQueue = .main,
        decodingQueue: DispatchQueue? = nil,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> Domain.Cancelable {
        load(
            request,
            session: session,
            decoder: decoder,
            completionQueue: completionQueue,
            decodingQueue: decodingQueue,
            completion: completion
        )
    }
    
    func load(
        _ request: URLRequest,
        session: URLSession = .shared,
        completionQueue: DispatchQueue = .main,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Domain.Cancelable {
        load(request,
             session: session,
             completionQueue: completionQueue,
             completion: completion
        )
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
