import Foundation
import Domain

final class Context {
    let postsUseCase: PostsUseCase
    
    let dateToStringConverter: DateToStringConverter
    
    init(
        postsUseCase: PostsUseCase,
        dateToStringConverter: DateToStringConverter
    ) {
        self.postsUseCase = postsUseCase
        self.dateToStringConverter = dateToStringConverter
    }
}

extension Context: NoContext { }
extension Context: AutoProperties { }
