import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var context: Context!
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        context = ContextBuilder().build()
        return true
    }
    
    func start(window: UIWindow) {
        let coordinator = context.makeRootSceneCoordinator(navigation: window)
        coordinator.setScene()
    }
}
