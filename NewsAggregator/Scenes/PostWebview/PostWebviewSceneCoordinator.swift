import UIKit
import Domain

final class PostWebviewSceneCoordinator: AutoCoordinatorType {
    typealias Context = CoordinatorsFactory & PostWebviewSceneModel.Context
    typealias Navigator = ModalNavigatorType
    struct Configuration {
        let post: Post
    }
    
    private let context: Context
    private weak var navigation: Navigator?
    private let configuration: Configuration
    
    init(
        context: Context,
        configuration: Configuration
    ) {
        self.context = context
        self.configuration = configuration
    }
}

// MARK: - Implement CoordinatorType

extension PostWebviewSceneCoordinator: CoordinatorType {
    func makeScene() -> UIViewController {
        let config = PostWebviewSceneModel.Configuration(post: configuration.post)
        let sceneModel = PostWebviewSceneModel(
            context: context,
            configuration: config,
            router: asRouter()
        )
        let scene = PostWebviewScene().apply {
            $0.viewModel = sceneModel.asAnyViewModel()
        }
        let nc = UINavigationController(rootViewController: scene)
        nc.navigationBar.run {
            $0.scrollEdgeAppearance = $0.standardAppearance
        }
        navigation = nc
        return nc
    }
}

// MARK: - Implement RouterType

extension PostWebviewSceneCoordinator: RouterType {
    func handle(event: PostWebviewSceneUnit.Event) {
        switch event {
        case .close:
            navigation?.dismiss(animated: true, completion: .none)
        case .alert(let block):
            navigation?.presentAlert(block: block)
        }
    }
}
