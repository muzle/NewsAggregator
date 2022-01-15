// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import UIKit
import Foundation

// MARK: - Setable for classes, structs

// MARK: - Post
extension Post {
    enum Part {
        case isFavorite(Bool)
        case addToFavoriteDate(Date?)
        case visitCount(Int)
    }
    func byAdding(_ parts: Part...) -> Post {
        byAdding(parts)
    }
    func byAdding(_ parts: [Part]) -> Post {
        guard !parts.isEmpty else { return self }
        var value = self
        for part in parts {
            value.update(part)
        }
        return value
    }
    private mutating func update(_ part: Part) {
        switch part {
        case .isFavorite(let isFavorite):
            self.isFavorite = isFavorite
        case .addToFavoriteDate(let addToFavoriteDate):
            self.addToFavoriteDate = addToFavoriteDate
        case .visitCount(let visitCount):
            self.visitCount = visitCount
        }
    }
}
