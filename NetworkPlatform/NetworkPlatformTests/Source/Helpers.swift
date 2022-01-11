import Foundation

private class A { }

func readFileData(fileName: String, ofType: String = "json") throws -> Data {
    guard
        let path = Bundle(for: A.self).path(forResource: fileName, ofType: ofType),
        let data = NSData(contentsOfFile: path)
    else {
        throw URLError(.badURL)
    }
    return data as Data
}
