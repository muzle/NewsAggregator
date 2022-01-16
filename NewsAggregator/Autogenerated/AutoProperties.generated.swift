// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import Domain

// MARK: - Context

protocol HasPostsUseCase { var postsUseCase: PostsUseCase { get } }
extension Context: HasPostsUseCase { }

protocol HasAppSettingsUseCase { var appSettingsUseCase: AppSettingsUseCase { get } }
extension Context: HasAppSettingsUseCase { }

protocol HasDateToStringConverter { var dateToStringConverter: DateToStringConverter { get } }
extension Context: HasDateToStringConverter { }
