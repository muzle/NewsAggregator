import UIKit
import Domain

final class SettingsSceneCoordinator: AutoCoordinatorType {
    typealias Context = CoordinatorsFactory & SettingsSceneModel.Context
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

extension SettingsSceneCoordinator: CoordinatorType {
    func makeScene() -> UIViewController {
        let sceneModel = SettingsSceneModel(
            context: context,
            router: asRouter()
        )
        let scene = SettingsScene()
        scene.viewModel = sceneModel.asAnyViewModel()
        return scene
    }
    
    func setScene() {
        navigation?.push(makeScene(), animated: true)
    }
}

// MARK: - Implement RouterType

extension SettingsSceneCoordinator: RouterType {
    func handle(event: SettingsSceneUnit.Event) {
        switch event {
        case .alert(let block):
            navigation?.presentAlert(block: block)
        }
    }
}
