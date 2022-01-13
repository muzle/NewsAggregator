import UIKit
import RxSwift
import RxCocoa

final class PostsScene: UIViewController, ViewModelBindable {
    typealias ContentView = PostsSceneView
    typealias Unit = PostsSceneUnit
    typealias ViewModel = Unit.ViewModel
    
    var viewModel: ViewModel?
    private let disposeBag = DisposeBag()
    
    private lazy var contentView = ContentView()
}

// MARK: - Life cycle

extension PostsScene {
    override func loadView() {
        view = contentView
    }

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

extension PostsScene {
    func bind(viewModel: ViewModel) {
        let input = ViewModel.Input()
        let output = viewModel.transform(input: input)
        
        disposeBag.insert(
            output.empty.emit()
        )
    }
}

// MARK: - Common init

private extension PostsScene {
    func commonInit() {
        
    }
}
