import UIKit
import RxSwift
import RxCocoa
import WebKit
import Lottie

private struct Constants {
    let closeControlContentInset = UIEdgeInsets(all: 16)
    let lottieAnimationFileName = "loadingAnimation"
}
private let constants = Constants()

final class PostWebviewScene: UIViewController, ViewModelBindable {
    typealias Unit = PostWebviewSceneUnit
    typealias ViewModel = Unit.ViewModel
    
    var viewModel: ViewModel?
    private let disposeBag = DisposeBag()
    
    private let webview = WKWebView()
    private weak var animationView: UIView?
    private let closeButton = UIBarButtonItem()
}

// MARK: - Life cycle

extension PostWebviewScene {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else {
            preconditionFailure("viewModel must be assigned before viewDidLoad")
        }
        commonInit()
        bind(viewModel: viewModel)
    }
}

// MARK: - Implement ViewModelBindable

extension PostWebviewScene {
    func bind(viewModel: ViewModel) {
        let input = ViewModel.Input(
            close: closeButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input: input)
        
        navigationItem.title = output.navigationTitle
        webview.run {
            if let request = output.urlRequest {
                $0.load(request)
            }
            $0.navigationDelegate = output.delegate
        }
        
        disposeBag.insert(
            output.showAnimation.drive(onNext: { [weak self] in self?.showAnimation(value: $0) }),
            output.empty.emit()
        )
    }
    
    private func showAnimation(value: Bool) {
        guard value else {
            animationView?.removeFromSuperview()
            return
        }
        guard animationView == nil else { return }
        let view = makeAnimationView()
        self.view.addSubview(view)
        view.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        self.animationView = view
    }
    
    private func makeAnimationView() -> UIView {
        AnimationView().apply {
            $0.animation = Animation.named(constants.lottieAnimationFileName)
            $0.play(fromProgress: 0, toProgress: 1, loopMode: .loop, completion: nil)
        }
    }
}

// MARK: - Common init

private extension PostWebviewScene {
    func commonInit() {
        setConstraints()
        setUI()
    }
    
    func setConstraints() {
        [webview].forEach(view.addSubview(_:))
        webview.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setUI() {
        navigationItem.rightBarButtonItem = closeButton
        closeButton.run {
            $0.image = Asset.ic24CloseX.image.withRenderingMode(.alwaysTemplate)
            $0.tintColor = Asset.commonIconColor.color
        }
    }
}
