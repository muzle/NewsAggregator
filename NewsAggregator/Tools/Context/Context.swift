import Foundation
import Domain

final class Context {
    let postsUseCase: PostsUseCase
    
    init(
        postsUseCase: PostsUseCase
    ) {
        self.postsUseCase = postsUseCase
    }
}

extension Context: NoContext { }
extension Context: AutoProperties { }
