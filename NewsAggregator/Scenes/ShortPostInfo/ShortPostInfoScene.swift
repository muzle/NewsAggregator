import UIKit
import RxSwift
import RxCocoa

final class ShortPostInfoScene: UIViewController, ViewModelBindable {
    typealias ContentView = ShortPostInfoSceneView
    typealias Unit = ShortPostInfoSceneUnit
    typealias ViewModel = Unit.ViewModel
    
    var viewModel: ViewModel?
    private let disposeBag = DisposeBag()
    
    private lazy var contentView = ContentView()
}

// MARK: - Life cycle

extension ShortPostInfoScene {
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

extension ShortPostInfoScene {
    func bind(viewModel: ViewModel) {
        let input = ViewModel.Input(
            tap: contentView.completeButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input: input)
        
        disposeBag.insert(
            output.image.drive(contentView.imageView.rx.image),
            output.title.drive(contentView.titleLabel.rx.text),
            output.description.drive(contentView.descriptionLabel.rx.text),
            output.empty.emit()
        )
    }
}

// MARK: - Common init

private extension ShortPostInfoScene {
    func commonInit() {
        
    }
}
