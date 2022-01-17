import UIKit
import Domain
import RxSwift
import RxCocoa

enum SwitchUnit: UnitType {
    enum Event {
        case isOn(Bool)
    }
    
    struct Input {
        let isOn: Signal<Bool>
    }
    
    struct Output {
        let isOn: Driver<Bool>
        let empty: Signal<Void>
    }
}

// MARK: - Implement SwitchUnit.ViewModel

final class SwitchModel: ViewModelType {
    typealias Unit = SwitchUnit
    typealias Router = Unit.Router
    struct Configuration {
        let isOn: Driver<Bool>
    }
    
    private let configuration: Configuration
    private let router: Router
    
    init(
        configuration: Configuration,
        router: Router
    ) {
        self.configuration = configuration
        self.router = router
    }
    
    func transform(input: Unit.Input) -> Unit.Output {
        let isOnEvent = input.isOn
            .map(Unit.Event.isOn)
            .route(with: router)
        
        return Unit.Output(
            isOn: configuration.isOn,
            empty: isOnEvent
        )
    }
}
