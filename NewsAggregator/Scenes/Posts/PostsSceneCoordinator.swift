import UIKit
import Domain

final class PostsSceneCoordinator: AutoCoordinatorType {
    typealias Context = CoordinatorsFactory & PostsSceneModel.Context
    typealias Navigator = NavigatorType
    
    private let context: Context
    private weak var navigation: Navigator?
    
    init(
        context: Context,
        navigation: Navigator?
    ) {
        self.context = context
        self.navigation = navigation
    }
}

// MARK: - Implement CoordinatorType

extension PostsSceneCoordinator: CoordinatorType {
    func makeScene() -> UIViewController {
        let sceneModel = PostsSceneModel(
            context: context,
            configuration: .init(),
            router: asRouter()
        )
        let scene = PostsScene()
        scene.viewModel = sceneModel.asAnyViewModel()
        return scene
    }
    
    func setScene() {
        let scene = makeScene()
        navigation?.push(scene, animated: true)
    }
}

// MARK: - Implement RouterType

extension PostsSceneCoordinator: RouterType {
    func handle(event: PostsSceneUnit.Event) {
    }
}
