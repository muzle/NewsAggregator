import UIKit
import RxSwift
import RxCocoa
import SnapKit

private struct Constants {
}
private let constants = Constants()

final class PostCard: UIView, ViewModelBindable {
    typealias Unit = PostCardUnit
    typealias ViewModel = Unit.ViewModel
    private let disposeBag = DisposeBag()
    
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

private extension PostCard {
    func commonInit() {
        setConstraints()
        localize()
        setUI()
    }
    
    func setConstraints() {
    
    }
    
    func localize() {
    
    }

    func setUI() {
    
    }
}

// MARK: - Implement ViewModelBindable

extension PostCard {
    func bind(viewModel: ViewModel) {
        let input = Unit.Input()
        let output = viewModel.transform(input: input)
        
        disposeBag.insert(
            output.empty.emit()
        )
    }
}
