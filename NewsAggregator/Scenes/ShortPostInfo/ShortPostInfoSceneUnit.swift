import Domain
import RxSwift
import RxCocoa

enum ShortPostInfoSceneUnit: UnitType {
    enum Event {
        case complete
    }
    
    struct Input {
        let tap: Signal<Void>
    }
    
    struct Output {
        let image: Driver<UIImage?>
        let title: Driver<String?>
        let description: Driver<String?>
        let empty: Signal<Void>
    }
}

final class ShortPostInfoSceneModel: ViewModelType {
    typealias Unit = ShortPostInfoSceneUnit
    typealias Router = Unit.Router
    typealias Context = HasPostsUseCase
    struct Configuration {
        let post: Post
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
        let completeEvent = input.tap
            .map { Unit.Event.complete }
            .route(with: router)
        
        let image = context.postsUseCase.image(for: configuration.post)
            .asDriver(onErrorJustReturn: nil)
        
        return Unit.Output(
            image: image,
            title: .just(configuration.post.title),
            description: .just(configuration.post.description),
            empty: completeEvent
        )
    }
}

// MARK: - ViewModel transform

private extension ShortPostInfoSceneModel {
    
}
