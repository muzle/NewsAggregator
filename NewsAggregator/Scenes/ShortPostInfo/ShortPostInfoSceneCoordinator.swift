import UIKit
import Domain

enum ShortPostInfoSceneCoordinatorEvent {
    case complete(Post)
}

final class ShortPostInfoSceneCoordinator: AutoCoordinatorType {
    typealias Context = CoordinatorsFactory & ShortPostInfoSceneModel.Context
    typealias Navigator = ModalNavigatorType
    typealias Router = AnyRouter<ShortPostInfoSceneCoordinatorEvent>
    struct Configuration {
        let post: Post
    }
    
    private let context: Context
    private weak var navigation: Navigator?
    private let configuration: Configuration
    private let router: Router
    
    init(
        context: Context,
        configuration: Configuration,
        router: Router
    ) {
        self.context = context
        self.configuration = configuration
        self.router = router
    }
}

// MARK: - Implement CoordinatorType

extension ShortPostInfoSceneCoordinator: CoordinatorType {
    func makeScene() -> UIViewController {
        let config = ShortPostInfoSceneModel.Configuration(
            post: configuration.post
        )
        let sceneModel = ShortPostInfoSceneModel(
            context: context,
            configuration: config,
            router: asRouter()
        )
        let scene = ShortPostInfoScene().apply {
            $0.viewModel = sceneModel.asAnyViewModel()
        }
        navigation = scene
        return scene
    }
}

// MARK: - Implement RouterType

extension ShortPostInfoSceneCoordinator: RouterType {
    func handle(event: ShortPostInfoSceneUnit.Event) {
        switch event {
        case .complete:
            navigation?.dismiss(animated: true) { [router, configuration] in
                router.handle(event: .complete(configuration.post))
            }
        }
    }
}
