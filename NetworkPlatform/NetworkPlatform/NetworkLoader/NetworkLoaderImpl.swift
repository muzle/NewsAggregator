import Foundation
import Domain

final class NetworkLoaderImpl: NetworkLoader {
    func load(
        _ request: URLRequest,
        session: URLSession = .shared,
        completionQueue: DispatchQueue = .main,
        completion: @escaping (Result<Void, Error>) -> Void
    ) -> Cancelable {
        let task = session.dataTask(with: request) { [self] data, respose, error in
            do {
                try checkResposeErrorAndStatusCode(error: error, respose: respose)
                completionQueue.sync {
                    completion(.success(()))
                }
            } catch {
                completionQueue.sync {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
        return task
    }
    
    func loadData(
        _ request: URLRequest,
        session: URLSession,
        completionQueue: DispatchQueue,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> Cancelable {
        let task = session.dataTask(with: request) { [self] data, respose, error in
            do {
                try checkResposeErrorAndStatusCode(error: error, respose: respose)
                guard let data = data else { throw NetworkLoaderError.emptyData }
                completionQueue.sync {
                    completion(.success(data))
                }
            } catch {
                completionQueue.sync {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
        return task
    }
    
    private func checkResposeErrorAndStatusCode(
        error: Error?,
        respose: URLResponse?
    ) throws {
        if let error = error {
            throw error
        }
        guard let statusCode = (respose as? HTTPURLResponse)?.statusCode else {
            throw NetworkLoaderError.invalideStatusCode(statusCode: nil)
        }
        guard (200...300).contains(statusCode) else {
            throw NetworkLoaderError.invalideStatusCode(statusCode: statusCode)
        }
    }
}
