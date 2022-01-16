// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import UIKit

protocol CoordinatorsFactory {
    func makePostWebviewSceneCoordinator(
        configuration: PostWebviewSceneCoordinator.Configuration
    ) -> PostWebviewSceneCoordinator
    func makePostsSceneCoordinator(
        navigation: NavigatorType?
    ) -> PostsSceneCoordinator
    func makeRootSceneCoordinator(
        navigation: SingleNavigatorType
    ) -> RootSceneCoordinator
    func makeSettingsSceneCoordinator(
        navigation: NavigatorType?
    ) -> SettingsSceneCoordinator
    func makeShortPostInfoSceneCoordinator(
        configuration: ShortPostInfoSceneCoordinator.Configuration,
        router: AnyRouter<ShortPostInfoSceneCoordinatorEvent>
    ) -> ShortPostInfoSceneCoordinator
    func makeTabBarSceneCoordinator(
    ) -> TabBarSceneCoordinator
}

extension Context: CoordinatorsFactory {
    func makePostWebviewSceneCoordinator(
        configuration: PostWebviewSceneCoordinator.Configuration
    ) -> PostWebviewSceneCoordinator {
        PostWebviewSceneCoordinator(
                context: self,
                configuration: configuration
        )
    }
    func makePostsSceneCoordinator(
        navigation: NavigatorType?
    ) -> PostsSceneCoordinator {
        PostsSceneCoordinator(
                context: self,
                navigation: navigation
        )
    }
    func makeRootSceneCoordinator(
        navigation: SingleNavigatorType
    ) -> RootSceneCoordinator {
        RootSceneCoordinator(
                context: self,
                navigation: navigation
        )
    }
    func makeSettingsSceneCoordinator(
        navigation: NavigatorType?
    ) -> SettingsSceneCoordinator {
        SettingsSceneCoordinator(
                context: self,
                navigation: navigation
        )
    }
    func makeShortPostInfoSceneCoordinator(
        configuration: ShortPostInfoSceneCoordinator.Configuration,
        router: AnyRouter<ShortPostInfoSceneCoordinatorEvent>
    ) -> ShortPostInfoSceneCoordinator {
        ShortPostInfoSceneCoordinator(
                context: self,
                configuration: configuration,
                router: router
        )
    }
    func makeTabBarSceneCoordinator(
    ) -> TabBarSceneCoordinator {
        TabBarSceneCoordinator(
                context: self
        )
    }
}
