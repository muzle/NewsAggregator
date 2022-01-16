import Domain
import RxSwift
import RxCocoa

enum SettingsSceneUnit: UnitType {
    enum Event {
    }
    
    struct Input {
    }
    
    struct Output {
        let empty: Signal<Void>
    }
}

final class SettingsSceneModel: ViewModelType {
    typealias Unit = SettingsSceneUnit
    typealias Router = Unit.Router
    typealias Context = NoContext
    
    private let context: Context
    private let router: Unit.Router
    
    init(
        context: Context,
        router: Router
    ) {
        self.context = context
        self.router = router
    }
    
    func transform(input: Unit.Input) -> Unit.Output {
        return Unit.Output(
            empty: .never()
        )
    }
}

// MARK: - ViewModel transform

private extension SettingsSceneModel {
    
}
