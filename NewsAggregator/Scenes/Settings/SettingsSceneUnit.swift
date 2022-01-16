import Domain
import RxSwift
import RxCocoa

enum SettingsSceneUnit: UnitType {
    typealias FieldModel = SettingsItemCardUnit<TextFieldUnit.ViewModel>.ViewModel
    enum Event {
    }
    
    struct Input {
    }
    
    struct Output {
        let dataSource: Driver<[Section]>
        let empty: Signal<Void>
    }
    
    struct Section {
        let title: String
        let models: [CellModelType]
    }
    
    enum CellModelType {
        case field(FieldModel)
    }
}

final class SettingsSceneModel: ViewModelType {
    typealias Unit = SettingsSceneUnit
    typealias Router = Unit.Router
    typealias Context = NoContext
    
    private let context: Context
    private let router: Unit.Router
    private let updateTimeRelay = PublishRelay<String>()
    
    init(
        context: Context,
        router: Router
    ) {
        self.context = context
        self.router = router
    }
    
    func transform(input: Unit.Input) -> Unit.Output {
        
        return Unit.Output(
            dataSource: .just([makeRefresheSection()]),
            empty: .never()
        )
    }
}

// MARK: - ViewModel transform

private extension SettingsSceneModel {
    private func makeRefresheSection() -> Unit.Section {
        let config = SettingsItemCardModel<TextFieldUnit.ViewModel>.Configuration(
            title: GSln.SettingsScene.postsLoadTimeInterval,
            viewModel: makeUpdateTimeFieldModel()
        )
        let model = SettingsItemCardModel(
            configuration: config
        )
        let modelTypes: [Unit.CellModelType] = [
            .field(model.asAnyViewModel())
        ]
        let section = Unit.Section(
            title: "AS",
            models: modelTypes
        )
        return section
    }
    
    func makeUpdateTimeFieldModel() -> TextFieldUnit.ViewModel {
        let router = TextFieldUnit.Router { [updateTimeRelay] event in
            switch event {
            case .text(let text):
                updateTimeRelay.accept(text)
            }
        }
        let model = TextFieldModel(
            configuration: .init(),
            router: router
        )
        return model.asAnyViewModel()
    }
}
