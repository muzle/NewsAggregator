import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class Switch: UISwitch, ViewModelBindable {
    typealias Unit = SwitchUnit
    typealias ViewModel = Unit.ViewModel
    private var disposeBag = DisposeBag()
}

// MARK: - Implement ViewModelBindable

extension Switch {
    func bind(viewModel: ViewModel) {
        let input = Unit.Input(
            isOn: rx.isOn.asSignal(onErrorSignalWith: .empty())
        )
        let output = viewModel.transform(input: input)
        
        disposeBag.insert(
            output.isOn.drive(rx.isOn),
            output.empty.emit()
        )
    }
}

// MARK: - Implement ReactiveReusable

extension Switch: ReactiveReusable {
    func reuse() {
        disposeBag = DisposeBag()
    }
}
