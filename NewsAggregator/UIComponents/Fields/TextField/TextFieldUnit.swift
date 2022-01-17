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
        let text: Driver<String?>
        let placeholder: Driver<String?>
        let isEnable: Driver<Bool>
        let isErrorState: Driver<Bool>
        let keyboardType: UIKeyboardType
        let delegate: UITextFieldDelegate
        let empty: Signal<Void>
    }
}

// MARK: - Implement TextFieldUnit.ViewModel

final class TextFieldModel: NSObject, ViewModelType {
    typealias Unit = TextFieldUnit
    typealias Router = Unit.Router
    struct Configuration {
        let text: Driver<String?>
        let placeholder: Driver<String?>
        let isEnable: Driver<Bool>
        let isErrorState: Driver<Bool>
        let keyboardType: UIKeyboardType
        let filterRule: ((String) -> Bool)?
        
        init(
            text: Driver<String?> = .never(),
            placeholder: Driver<String?> = .never(),
            isEnable: Driver<Bool> = .never(),
            isErrorState: Driver<Bool> = .never(),
            keyboardType: UIKeyboardType = .numberPad,
            filterRule: ((String) -> Bool)? = nil
        ) {
            self.text = text
            self.placeholder = placeholder
            self.isEnable = isEnable
            self.isErrorState = isErrorState
            self.keyboardType = keyboardType
            self.filterRule = filterRule
        }
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
            text: configuration.text,
            placeholder: configuration.placeholder,
            isEnable: configuration.isEnable,
            isErrorState: configuration.isErrorState,
            keyboardType: configuration.keyboardType,
            delegate: self,
            empty: textEevent
        )
    }
}

// MARK: - Implement UITextFieldDelegate

extension TextFieldModel: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        configuration.filterRule?(string) ?? true
    }
}
