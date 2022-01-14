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
            router: .init(handle(event:))
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

// MARK: - Handle PostsSceneUnit.Event

extension PostsSceneCoordinator {
    func handle(event: PostsSceneUnit.Event) {
        switch event {
        case .post(let post):
            let config = ShortPostInfoSceneCoordinator.Configuration(post: post)
            let coordinator = context.makeShortPostInfoSceneCoordinator(
                configuration: config,
                router: .init(handle(event:))
            )
            let scene = coordinator.makeScene()
            navigation?.present(scene, animated: true)
        }
    }
}

// MARK: - Handle ShortPostInfoSceneCoordinatorEvent

extension PostsSceneCoordinator {
    func handle(event: ShortPostInfoSceneCoordinatorEvent) {
        switch event {
        case .complete(let post):
            let config = PostWebviewSceneCoordinator.Configuration(post: post)
            let coordinator = context.makePostWebviewSceneCoordinator(configuration: config)
            let scene = coordinator.makeScene()
            navigation?.present(scene, animated: true)
        }
    }
}
