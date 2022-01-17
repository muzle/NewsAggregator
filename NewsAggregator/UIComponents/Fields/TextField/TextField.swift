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

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

// MARK: - CommonInit

private extension TextField {
    func commonInit() {
        setUI()
        applyStyle()
    }
    
    func setUI() {
        borderStyle = .roundedRect
    }
    
    func applyStyle() {
        applyTextStyle(TextStyleFactory.Message.center)
    }
}

// MARK: - Implement ViewModelBindable

extension TextField {
    func bind(viewModel: ViewModel) {
        let input = Unit.Input(
            text: rx.text.orEmpty.asDriver()
        )
        let output = viewModel.transform(input: input)
        keyboardType = output.keyboardType
        delegate = output.delegate
        disposeBag.insert(
            output.text.drive(rx.text),
            output.placeholder.drive(rx.placeholder),
            output.isEnable.drive(rx.isEnabled),
            output.isErrorState.drive(onNext: { [weak self] in self?.setErrorState(value: $0) }),
            output.empty.emit()
        )
    }
    
    private func setErrorState(value: Bool) {
        layer.borderWidth = value ? 1 : 0
        layer.borderColor = value ? UIColor.red.cgColor : UIColor.clear.cgColor
    }
}

// MARK: - Implement ReactiveReusable

extension TextField: ReactiveReusable {
    func reuse() {
        disposeBag = DisposeBag()
    }
}
