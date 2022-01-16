import UIKit
import Domain

final class TabBarSceneCoordinator: AutoCoordinatorType {
    typealias Context = CoordinatorsFactory & TabBarSceneModel.Context
    typealias Navigator = SetNavigatorType
    private typealias SupportedSceneType = TabBarSceneUnit.SupportedSceneType
    
    private let context: Context
    private weak var navigation: Navigator?
    private var scenesContainer = [SupportedSceneType: UIViewController]()
    
    init(
        context: Context
    ) {
        self.context = context
    }
}

// MARK: - Implement CoordinatorType

extension TabBarSceneCoordinator: CoordinatorType {
    func makeScene() -> UIViewController {
        let sceneModel = TabBarSceneModel(
            context: context,
            configuration: .init(),
            router: asRouter()
        )
        let scene = TabBarScene()
        navigation = scene
        scene.run {
            $0.viewModel = sceneModel.asAnyViewModel()
        }
        return scene
    }
}

// MARK: - Implement RouterType

extension TabBarSceneCoordinator: RouterType {
    func handle(event: TabBarSceneUnit.Event) {
        switch event {
        case .setScenes(let sceneTypes):
            var controllers = [UIViewController]()
            var scenesContainer = [SupportedSceneType: UIViewController]()
            for sceneType in sceneTypes {
                let scene = self.scenesContainer[sceneType] ?? makeScene(for: sceneType)
                scenesContainer[sceneType] = scene
                controllers.append(scene)
            }
            self.scenesContainer = scenesContainer
            navigation?.setItems(items: controllers, animated: true)
        }
    }
    
    private func makeScene(for sceneType: SupportedSceneType) -> UIViewController {
        let scene: UIViewController
        switch sceneType {
        case .posts:
            let nc = UINavigationController()
            let coordinator = context.makePostsSceneCoordinator(navigation: nc)
            coordinator.setScene()
            scene = nc
        case .settings:
            let nc = UINavigationController()
            let coordinator = context.makeSettingsSceneCoordinator(navigation: nc)
            coordinator.setScene()
            scene = nc
        }
        return scene.apply {
            $0.view.tag = sceneType.rawValue
            $0.tabBarItem = makeTabbarItem(for: sceneType)
        }
    }
    
    private func makeTabbarItem(for sceneType: SupportedSceneType) -> UITabBarItem {
        UITabBarItem().apply {
            $0.title = makeTabbarItemTitle(for: sceneType)
            $0.image = makeTabbarItemIcon(for: sceneType)
        }
    }
    
    private func makeTabbarItemTitle(for sceneType: SupportedSceneType) -> String {
        switch sceneType {
        case .posts:
            return GSln.TabBarTitle.posts
        case .settings:
            return GSln.TabBarTitle.settings
        }
    }
    
    private func makeTabbarItemIcon(for sceneType: SupportedSceneType) -> UIImage {
        switch sceneType {
        case .posts:
            return Asset.ic24TabBarNews.image
        case .settings:
            return Asset.ic24TabBarSettings.image
        }
    }
}
