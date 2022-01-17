import Domain
import RxSwift
import RxCocoa

enum SettingsSceneUnit: UnitType {
    typealias FieldModel = SettingsItemCardUnit<TextFieldUnit.ViewModel>.ViewModel
    typealias SwitchModel = SettingsItemCardUnit<SwitchUnit.ViewModel>.ViewModel
    enum Event {
        case alert(AlertConfigurationBlock)
    }
    
    struct Input {
        let save: Signal<Void>
    }
    
    struct Output {
        let dataSource: Driver<[Section]>
        let saveIsEnabled: Driver<Bool>
        let empty: Signal<Void>
    }
    
    struct Section {
        let title: String
        let models: [CellModelType]
    }
    
    enum CellModelType {
        case field(FieldModel)
        case `switch`(SwitchModel)
    }
}

final class SettingsSceneModel: ViewModelType {
    typealias Unit = SettingsSceneUnit
    typealias Router = Unit.Router
    typealias Context = HasAppSettingsService
    
    private let context: Context
    private let router: Unit.Router
    private let appSettingsRelay: BehaviorRelay<AppSettings>
    
    init(
        context: Context,
        router: Router
    ) {
        self.context = context
        self.router = router
        
        do {
            let settings = try context.appSettingsService.settingsModel()
            appSettingsRelay = .init(value: settings)
        } catch {
            appSettingsRelay = .init(value: .makeDefault())
        }
    }
    
    func transform(input: Unit.Input) -> Unit.Output {
        let errorTracker = ErrorTracker()
        
        let appSettings = context.appSettingsService.settings()
            .trackToDriver(errorTracker)
        
        let dataSource = appSettings
            .map { $0.resourcesTrackingStates }
            .map { [self] in [makeRefresheSection(), makeTrackingSection(states: $0)] }
        
        let saveIsEnabled = Driver
            .combineLatest(appSettings, appSettingsRelay.asDriver()) { $0 != $1 }
            .distinctUntilChanged()
        
        let saveEvent = input.save
            .withLatestFrom(appSettingsRelay.trackToSignal(errorTracker))
            .flatMap(
                context.appSettingsService.udpate(settings:),
                errorTracker: errorTracker
            )
        let errorAlertEvent = errorTracker.asSignal()
            .map(makeErrorAlertBlock(error:))
            .map(Unit.Event.alert)
            .route(with: router)
        
        let empty = Signal
            .merge(saveEvent, errorAlertEvent)
        
        return Unit.Output(
            dataSource: dataSource,
            saveIsEnabled: saveIsEnabled,
            empty: empty
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
            title: GSln.SettingsScene.refreshTimeSectionTitle,
            models: modelTypes
        )
        return section
    }
    
    private func makeUpdateTimeFieldModel() -> TextFieldUnit.ViewModel {
        let router = TextFieldUnit.Router { [context, appSettingsRelay] event in
            switch event {
            case .text(let text):
                guard
                    let int = Int(text),
                    context.appSettingsService.isValidRefreshTim(value: int)
                else {
                    appSettingsRelay.accept(appSettingsRelay.value.byAdding(.refreshTimeInternalMin(0)))
                    return
                }
                appSettingsRelay.accept(appSettingsRelay.value.byAdding(.refreshTimeInternalMin(int)))
            }
        }
        let config = TextFieldModel.Configuration(
            text: context.appSettingsService.settings().map { "\($0.refreshTimeInternalMin)" }.asDriver(onErrorJustReturn: ""),
            isErrorState: appSettingsRelay
                .map { [context] in !context.appSettingsService.isValidRefreshTim(value: $0.refreshTimeInternalMin) }
                .asDriver(onErrorJustReturn: false),
            keyboardType: .numberPad,
            filterRule: { Int($0) != nil || $0.isDelite }
        )
        let model = TextFieldModel(
            configuration: config,
            router: router
        )
        return model.asAnyViewModel()
    }
    
    private func makeTrackingSection(states: [ResourceTrackingState]) -> Unit.Section {
        return Unit.Section(
            title: GSln.SettingsScene.trackedReourcesSectionTitle,
            models: states.map(makeSwitchSettinsModel(state:)).map(Unit.CellModelType.switch)
        )
    }
    
    private func makeSwitchSettinsModel(state: ResourceTrackingState) -> Unit.SwitchModel {
        let config = SettingsItemCardModel<SwitchUnit.ViewModel>.Configuration(
            title: state.resource.name,
            viewModel: makeSwitchModel(state: state)
        )
        let model = SettingsItemCardModel(configuration: config)
        return model.asAnyViewModel()
    }
    
    private func makeSwitchModel(state: ResourceTrackingState) -> SwitchUnit.ViewModel {
        let isOn = context.appSettingsService
            .settings()
            .map { [state] in $0.resourcesTrackingStates.first(where: { $0.resource.id == state.resource.id })?.isTacked }
            .asDriver(onErrorJustReturn: nil)
            .map { $0 ?? false }
        
        return makeSwitchModel(
            isOn: isOn,
            isOnCompletion: { [appSettingsRelay, state] value in
                var currentValue = appSettingsRelay.value
                currentValue.setNewTrackedState(for: state.resource.id, value: value)
                appSettingsRelay.accept(currentValue)
            }
        )
    }
    
    private func makeSwitchModel(
        isOn: Driver<Bool>,
        isOnCompletion: @escaping (Bool) -> Void
    ) -> SwitchUnit.ViewModel {
        let config = SwitchModel.Configuration(isOn: isOn)
        let router = SwitchModel.Router { event in
            switch event {
            case .isOn(let value):
                isOnCompletion(value)
            }
        }
        let model = SwitchModel(configuration: config, router: router)
        return model.asAnyViewModel()
    }
    
    private func makeErrorAlertBlock(error: Error) -> AlertConfigurationBlock {
        let config = AlertConfiguration.makeErrorAlert(message: error.localizedDescription)
        let block = AlertConfigurationBlock(alertConfiguration: config)
        return block
    }
}
