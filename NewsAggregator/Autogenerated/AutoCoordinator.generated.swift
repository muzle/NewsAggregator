// Generated using Sourcery 1.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import UIKit

protocol CoordinatorsFactory {
    func makePostsSceneCoordinator(
        navigation: NavigatorType?
    ) -> PostsSceneCoordinator
    func makeRootSceneCoordinator(
        navigation: SingleNavigatorType
    ) -> RootSceneCoordinator
}

extension Context: CoordinatorsFactory {
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
}
