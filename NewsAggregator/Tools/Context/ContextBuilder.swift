import Foundation

final class ContextBuilder {
    func build() -> Context {
        return Context(
            postsUseCase: PostsUseCaseMock(),
            dateToStringConverter: DateToStringConverterImpl()
        )
    }
}
