import Domain
import RxSwift
import RxCocoa
import WebKit

enum PostWebviewSceneUnit: UnitType {
    enum Event {
        case close
        case alert(AlertConfigurationBlock)
    }
    
    struct Input {
        let close: Signal<Void>
    }
    
    // swiftlint:disable weak_delegate
    struct Output {
        let navigationTitle: String?
        let urlRequest: URLRequest?
        let delegate: WKNavigationDelegate
        let showAnimation: Driver<Bool>
        let empty: Signal<Void>
    }
    // swiftlint:enable weak_delegate
}

final class PostWebviewSceneModel: NSObject, ViewModelType {
    typealias Unit = PostWebviewSceneUnit
    typealias Router = Unit.Router
    typealias Context = NoContext
    struct Configuration {
        let post: Post
    }
    
    private let context: Context
    private let configuration: Configuration
    private let router: Unit.Router
    private let animationRelay = BehaviorRelay<Bool>(value: true)
    
    init(
        context: Context,
        configuration: Configuration,
        router: Router
    ) {
        self.context = context
        self.configuration = configuration
        self.router = router
        super.init()
    }
    
    func transform(input: Unit.Input) -> Unit.Output {
        let closeEvent = input.close
            .map { Unit.Event.close }
            .route(with: router)
        
        var urlRequest: URLRequest?
        if let url = configuration.post.link {
            urlRequest = URLRequest(url: url)
        }
        
        if urlRequest == nil {
            DispatchQueue.main.async { [self] in
                router.handle(event: .alert(makeNotWalidUrlAlertBlock()))
            }
        }
        
        return Unit.Output(
            navigationTitle: configuration.post.category,
            urlRequest: urlRequest,
            delegate: self,
            showAnimation: animationRelay.asDriver().distinctUntilChanged(),
            empty: closeEvent
        )
    }
}

// MARK: - Implement WKNavigationDelegate

extension PostWebviewSceneModel: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        didStartProvisionalNavigation navigation: WKNavigation!
    ) {
        animationRelay.accept(true)
    }
    
    func webView(
        _ webView: WKWebView,
        didCommit navigation: WKNavigation!
    ) {
        animationRelay.accept(false)
    }
    
    func webView(
        _ webView: WKWebView,
        didFinish navigation: WKNavigation!
    ) {
        animationRelay.accept(false)
    }
}

// MARK: - ViewModel transform

private extension PostWebviewSceneModel {
    func makeNotWalidUrlAlertBlock() -> AlertConfigurationBlock {
        let config = AlertConfiguration(
            title: GSln.InvalidPostUrlAlert.title,
            message: GSln.InvalidPostUrlAlert.message,
            action: GSln.InvalidPostUrlAlert.ok,
            style: .error,
            position: .bottom
        )
        let block = AlertConfigurationBlock(
            alertConfiguration: config,
            actionCompletion: { [router] in router.handle(event: .close) }
        )
        return block
    }
}
