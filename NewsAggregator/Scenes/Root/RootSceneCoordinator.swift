import Foundation
import UIKit
import Domain

final class RootSceneCoordinator: AutoCoordinatorType {
    typealias Context = CoordinatorsFactory
    typealias Navigator = SingleNavigatorType
    
    private let context: Context
    private var navigation: Navigator
    
    init(
        context: Context,
        navigation: Navigator
    ) {
        self.context = context
        self.navigation = navigation
    }
}

// MARK: - Implement CoordinatorType

extension RootSceneCoordinator: CoordinatorType {
    func makeScene() -> UIViewController {
        let coordinator = context.makeTabBarSceneCoordinator()
        return coordinator.makeScene()
    }
    
    func setScene() {
        makeScene().run {
            navigation.put($0)
        }
    }
}
