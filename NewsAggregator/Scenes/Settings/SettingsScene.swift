import UIKit
import RxSwift
import RxCocoa

final class SettingsScene: UIViewController, ViewModelBindable {
    typealias ContentView = SettingsSceneView
    typealias Unit = SettingsSceneUnit
    typealias ViewModel = Unit.ViewModel
    
    var viewModel: ViewModel?
    private let disposeBag = DisposeBag()
    
    typealias Section = Unit.Section
    typealias FieldCell = TableViewWrapperCell<SettingsItemCard<TextField>>
    typealias SwitchCell = TableViewWrapperCell<SettingsItemCard<Switch>>
    private var dataSource = [Section]()
    private lazy var contentView = ContentView()
    private let saveButton = UIBarButtonItem()
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
        let input = ViewModel.Input(
            save: saveButton.rx.tap.asSignal()
        )
        let output = viewModel.transform(input: input)
        
        disposeBag.insert(
            output.dataSource.drive(onNext: { [weak self] in self?.dataSource = $0; self?.contentView.tableView.reloadData() }),
            output.saveIsEnabled.drive(saveButton.rx.isEnabled),
            output.empty.emit()
        )
    }
}

// MARK: - Common init

private extension SettingsScene {
    func commonInit() {
        navigationItem.run {
            $0.title = GSln.SettingsScene.navigationTitle
            $0.rightBarButtonItem = saveButton
        }
        saveButton.run {
            $0.title = GSln.SettingsScene.saveButtonTitle
        }
        contentView.tableView.run {
            $0.register(FieldCell.self)
            $0.register(SwitchCell.self)
            $0.dataSource = self
        }
    }
}

// MARK: - Implement UITableViewDataSource

extension SettingsScene: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        dataSource[section].models.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let section = dataSource[indexPath.section]
        let modelType = section.models[indexPath.row]
        let cell: UITableViewCell
        switch modelType {
        case .field(let model):
            cell = tableView.dequeueReusableCell(FieldCell.self, for: indexPath).apply {
                $0.bind(viewModel: model)
            }
        case .switch(let model):
            cell = tableView.dequeueReusableCell(SwitchCell.self, for: indexPath).apply {
                $0.bind(viewModel: model)
            }
        }
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        dataSource[section].title
    }
}
