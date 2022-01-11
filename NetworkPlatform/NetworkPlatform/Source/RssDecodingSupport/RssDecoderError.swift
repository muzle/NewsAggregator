import Foundation

internal enum RssDecoderError: Error {
    case foundCDATA(path: String)
    case emtyChanelInResult
}
