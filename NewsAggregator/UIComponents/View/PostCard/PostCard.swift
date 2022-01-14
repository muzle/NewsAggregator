import UIKit
import RxSwift
import RxCocoa
import SnapKit

private struct Constants {
    let labelsStackViewSpacing = CGFloat(8)
    let contentStackViewSpacing = CGFloat(8)
    let contentInset = UIEdgeInsets(all: 16)
}
private let constants = Constants()

final class PostCard: UIView, ViewModelBindable {
    typealias Unit = PostCardUnit
    typealias ViewModel = Unit.ViewModel
    private let disposeBag = DisposeBag()
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let sourceInfoLabel = UILabel()
    
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
        let labelsStackView = UIStackView(arrangedSubviews: [titleLabel, sourceInfoLabel]).apply {
            $0.axis = .vertical
            $0.spacing = constants.labelsStackViewSpacing
        }
        let contentStackView = UIStackView(arrangedSubviews: [imageView, labelsStackView]).apply {
            $0.axis = .horizontal
            $0.spacing = constants.contentStackViewSpacing
        }
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(constants.contentInset)
        }
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
        
        let sourceText = makeSourceInfo(for: output.sourceName, output.publicationDate, output.category)
        
        titleLabel.text = output.title
        sourceInfoLabel.text = sourceText
        imageView.isHidden = !output.withImage
        
        disposeBag.insert(
            output.image.drive(imageView.rx.image)
        )
    }
    
    private func makeSourceInfo(for texts: String?...) -> String? {
        let texts = texts.compactMap { $0 }.filter { !$0.isEmpty }
        guard !texts.isEmpty else { return nil }
        return texts.joined(separator: " * ")
    }
}
