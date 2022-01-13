import Domain
import RxSwift
import RxCocoa

enum PostsSceneUnit: UnitType {
    typealias CellModel = PostCardUnit.ViewModel
    enum Event {
    }
    
    struct Input {
        let selectedItem: Signal<IndexPath>
    }
    
    struct Output {
        let dataSource: Driver<[CellModel]>
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
            dataSource: .never(),
            empty: .never()
        )
    }
}

// MARK: - ViewModel transform

private extension PostsSceneModel {
    
}
