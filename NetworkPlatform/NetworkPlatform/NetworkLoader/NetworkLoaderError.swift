import Foundation

internal enum NetworkLoaderError: Error {
    case invalideStatusCode(statusCode: Int?)
    case emptyData
}
