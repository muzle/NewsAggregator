import UIKit
import RxSwift
import RxCocoa
import SnapKit

private struct Constants {
}
private let constants = Constants()

final class TextField: UITextField, ViewModelBindable {
    typealias Unit = TextFieldUnit
    typealias ViewModel = Unit.ViewModel
    private var disposeBag = DisposeBag()

}

// MARK: - Implement ViewModelBindable

extension TextField {
    func bind(viewModel: ViewModel) {
        let input = Unit.Input(
            text: rx.text.orEmpty.asDriver()
        )
        let output = viewModel.transform(input: input)
        
        disposeBag.insert(
            output.empty.emit()
        )
    }
}

// MARK: - Implement ReactiveReusable

extension TextField: ReactiveReusable {
    func reuse() {
        disposeBag = DisposeBag()
    }
}
