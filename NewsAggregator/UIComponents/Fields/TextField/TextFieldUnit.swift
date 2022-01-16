import UIKit
import Domain
import RxSwift
import RxCocoa

enum TextFieldUnit: UnitType {
    enum Event {
        case text(String)
    }
    
    struct Input {
        let text: Driver<String>
    }
    
    struct Output {
        let empty: Signal<Void>
    }
}

// MARK: - Implement TextFieldUnit.ViewModel

final class TextFieldModel: ViewModelType {
    typealias Unit = TextFieldUnit
    typealias Router = Unit.Router
    struct Configuration {
    
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
        let errorTracker = ErrorTracker()
        
        let textEevent = input.text
            .map(Unit.Event.text)
            .route(with: router)
            .trackToSignal(errorTracker)
        
        return Unit.Output(
            empty: textEevent
        )
    }
}
