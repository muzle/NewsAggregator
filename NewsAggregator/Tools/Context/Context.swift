import Foundation
import Domain

final class Context {
    let postsUseCase: PostsUseCase
    let appSettingsUseCase: AppSettingsUseCase
    
    let dateToStringConverter: DateToStringConverter
    
    init(
        postsUseCase: PostsUseCase,
        appSettingsUseCase: AppSettingsUseCase,
        dateToStringConverter: DateToStringConverter
    ) {
        self.postsUseCase = postsUseCase
        self.appSettingsUseCase = appSettingsUseCase
        self.dateToStringConverter = dateToStringConverter
    }
}

extension Context: NoContext { }
extension Context: AutoProperties { }
