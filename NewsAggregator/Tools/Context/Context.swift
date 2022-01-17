import Foundation
import Domain

final class Context {
    let postsUseCase: PostsUseCase
    let appSettingsService: AppSettingsService
    let dateToStringConverter: DateToStringConverter
    
    init(
        postsUseCase: PostsUseCase,
        appSettingsService: AppSettingsService,
        dateToStringConverter: DateToStringConverter
    ) {
        self.postsUseCase = postsUseCase
        self.appSettingsService = appSettingsService
        self.dateToStringConverter = dateToStringConverter
    }
}

extension Context: NoContext { }
extension Context: AutoProperties { }
