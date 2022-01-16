import UIKit
import RxSwift
import RxCocoa

final class SettingsScene: UIViewController, ViewModelBindable {
    typealias ContentView = SettingsSceneView
    typealias Unit = SettingsSceneUnit
    typealias ViewModel = Unit.ViewModel
    
    var viewModel: ViewModel?
    private let disposeBag = DisposeBag()
    
    private lazy var contentView = ContentView()
}

// MARK: - Life cycle

extension SettingsScene {
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

extension SettingsScene {
    func bind(viewModel: ViewModel) {
        let input = ViewModel.Input()
        let output = viewModel.transform(input: input)
        
        disposeBag.insert(
            output.empty.emit()
        )
    }
}

// MARK: - Common init

private extension SettingsScene {
    func commonInit() {
        navigationItem.title = GSln.SettingsScene.navigationTitle
    }
}
