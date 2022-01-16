import UIKit
import RxSwift
import RxCocoa

final class PostsScene: UIViewController, ViewModelBindable {
    typealias ContentView = PostsSceneView
    typealias Unit = PostsSceneUnit
    typealias ViewModel = Unit.ViewModel
    
    var viewModel: ViewModel?
    private let disposeBag = DisposeBag()
    
    typealias Cell = TableViewWrapperCell<PostCard>
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
        let input = ViewModel.Input(
            selectedItem: contentView.tableView.rx.itemSelected.asSignal()
        )
        let output = viewModel.transform(input: input)
        
        disposeBag.insert(
            output.dataSource.drive(contentView.tableView.rx.items(cellIdentifier: Cell.className, cellType: Cell.self)) {
                $2.bind(viewModel: $1)
            },
            output.updateCellFrame.emit(onNext: { [weak self] in self?.updateCell(indexPath: $0.indexPath, isBegin: $0.isBegin) }),
            output.empty.emit()
        )
    }
    
    private func updateCell(indexPath: IndexPath, isBegin: Bool) {
        guard
            let indexies = contentView.tableView.indexPathsForRows(in: contentView.tableView.bounds),
            indexies.contains(indexPath)
        else { return }
        contentView.tableView.run {
            isBegin ? $0.beginUpdates() : $0.endUpdates()
        }
    }
}

// MARK: - Common init

private extension PostsScene {
    func commonInit() {
        setUI()
        localize()
    }
    
    func setUI() {
        contentView.tableView.run {
            $0.register(Cell.self)
        }
    }
    
    func localize() {
        navigationItem.title = GSln.PostsScene.navigationTitle
    }
}
