import UIKit
import RxSwift
import RxCocoa
import SnapKit

private struct Constants {
    let stackViewSpacing = CGFloat(16)
    let stackViewInset = UIEdgeInsets.zero
}
private let constants = Constants()

final class SettingsItemCard<Component: UIView & ViewModelBindable>: UIView, ViewModelBindable {
    typealias Unit = SettingsItemCardUnit<Component.ViewModel>
    typealias ViewModel = Unit.ViewModel
    
    private let titleLabel = UILabel()
    private let component = Component()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func bind(viewModel: Unit.ViewModel) {
        let input = Unit.Input()
        let output = viewModel.transform(input: input)
        titleLabel.text = output.title
        component.bind(viewModel: output.viewModel)
    }
}

// MARK: - CommonInit

private extension SettingsItemCard {
    func commonInit() {
        setConstraints()
        applyStyle()
    }
    
    func setConstraints() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, component]).apply {
            $0.axis = .horizontal
            $0.spacing = constants.stackViewSpacing
        }
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(constants.stackViewInset)
        }
    }
    
    func applyStyle() {
        titleLabel.applyTextStyle(TextStyleFactory.Message.left)
    }
}

// MARK: - Implement ReactiveReusable

extension SettingsItemCard: ReactiveReusable {
    func reuse() {
        (component as? ReactiveReusable)?.reuse()
    }
}
