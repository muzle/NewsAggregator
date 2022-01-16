import Domain
import RxSwift
import RxCocoa

enum TabBarSceneUnit: UnitType {
    enum Event {
        case setScenes([SupportedSceneType])
    }
    
    struct Input {
    }
    
    struct Output {
        let empty: Signal<Void>
    }
    
    enum SupportedSceneType: Int, Hashable, CaseIterable {
        case posts = 0, settings
    }
}

final class TabBarSceneModel: ViewModelType {
    typealias Unit = TabBarSceneUnit
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
        router.handle(event: .setScenes(TabBarSceneUnit.SupportedSceneType.allCases))
        return Unit.Output(
            empty: .never()
        )
    }
}
