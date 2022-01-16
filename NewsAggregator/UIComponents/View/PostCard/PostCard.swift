import UIKit
import RxSwift
import RxCocoa
import SnapKit

private struct Constants {
    let labelsStackViewSpacing = CGFloat(8)
    let contentStackViewSpacing = CGFloat(16)
    let contentInset = UIEdgeInsets(all: 16)
    let watchImage = Asset.ic24Eye.image.withRenderingMode(.alwaysTemplate).withTintColor(Asset.commonIconColor.color)
}
private let constants = Constants()

final class PostCard: UIView, ViewModelBindable {
    typealias Unit = PostCardUnit
    typealias ViewModel = Unit.ViewModel
    private var disposeBag = DisposeBag()
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let sourceInfoLabel = UILabel()
    private let watchCountLabel = UILabel()
    
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
        applyStyle()
    }
    
    func setConstraints() {
        let labelsStackView = UIStackView(arrangedSubviews: [titleLabel, sourceInfoLabel, watchCountLabel]).apply {
            $0.axis = .vertical
            $0.spacing = constants.labelsStackViewSpacing
        }
        let contentStackView = UIStackView(arrangedSubviews: [imageView, labelsStackView]).apply {
            $0.axis = .horizontal
            $0.spacing = constants.contentStackViewSpacing
            $0.alignment = .center
        }
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(constants.contentInset)
        }
        imageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.2)
            $0.height.equalTo(imageView.snp.width)
        }
    }
    
    func applyStyle() {
        titleLabel.applyTextStyle(TextStyleFactory.BigMessage.left)
        sourceInfoLabel.applyTextStyle(TextStyleFactory.SmallMessage.left)
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
            output.image.drive(imageView.rx.image),
            output.watchCount.map { [weak self] in self?.makeWatchCountAttributedString(for: $0) }.drive(watchCountLabel.rx.attributedText),
            output.watchCountLabelIsHidden.drive(watchCountLabel.rx.isHidden),
            output.empty.emit()
        )
    }
    
    private func makeSourceInfo(for texts: String?...) -> String? {
        let texts = texts.compactMap { $0 }.filter { !$0.isEmpty }
        guard !texts.isEmpty else { return nil }
        return texts.joined(separator: " * ")
    }
    
    private func makeWatchCountAttributedString(for text: String) -> NSAttributedString {
        let attachment = NSTextAttachment().apply {
            $0.image = constants.watchImage
            $0.bounds = CGRect(
                origin: CGPoint(
                    x: 0,
                    y: -abs(constants.watchImage.size.height - TextStyleFactory.SmallMessage.left.font.lineHeight)/2
                ),
                size: constants.watchImage.size
            )
        }
        let mutableString = NSMutableAttributedString(attachment: attachment)
        mutableString.append(NSAttributedString(string: " \(text)", style: TextStyleFactory.BigMessage.left))
        return mutableString
    }
}

// MARK: - Implement ReactiveReusable

extension PostCard: ReactiveReusable {
    func reuse() {
        disposeBag = DisposeBag()
    }
}
