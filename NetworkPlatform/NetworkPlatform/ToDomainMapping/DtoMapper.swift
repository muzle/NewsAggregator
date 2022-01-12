import Foundation
import Domain

internal protocol DtoMapper {
    associatedtype Result
    
    func map(_ result: Result) -> PostsContainer
}
