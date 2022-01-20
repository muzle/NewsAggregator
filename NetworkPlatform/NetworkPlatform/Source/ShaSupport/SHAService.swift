import Foundation

internal protocol SHAService {
    func sha(for data: Data) throws -> String
    func sha<Model: Encodable>(
        for model: Model,
        with encoder: JSONEncoder
    ) throws -> String
}

// MARK: - SHAService default implementation

extension SHAService {
    func sha<Model: Encodable>(
        for model: Model,
        with encoder: JSONEncoder
    ) throws -> String {
        let data = try encoder.encode(model)
        return try sha(for: data)
    }
}
