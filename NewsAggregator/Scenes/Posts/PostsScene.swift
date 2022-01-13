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
            output.empty.emit()
        )
    }
}

// MARK: - Common init

private extension PostsScene {
    func commonInit() {
        setUI()
    }
    
    func setUI() {
        contentView.tableView.run {
            $0.register(Cell.self)
        }
    }
}
