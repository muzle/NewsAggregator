import Domain
import RxSwift
import RxCocoa

enum PostsSceneUnit: UnitType {
    enum Event {
    }
    
    struct Input {
    }
    
    struct Output {
        let empty: Signal<Void>
    }
}

final class PostsSceneModel: ViewModelType {
    typealias Unit = PostsSceneUnit
    typealias Router = Unit.Router
    typealias Context = NoContext
    struct Configuration {
    }
    
    private let context: Context
    private let configuration: Configuration
    private let router: Unit.Router
    
    init(
        context: Context,
        configuration: Configuration,
        router: Router
    ) {
        self.context = context
        self.configuration = configuration
        self.router = router
    }
    
    func transform(input: Unit.Input) -> Unit.Output {
        return Unit.Output(
            empty: .never()
        )
    }
}

// MARK: - ViewModel transform

private extension PostsSceneModel {
    
}
