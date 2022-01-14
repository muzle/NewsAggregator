import UIKit
import SnapKit

private struct Constants {
    let contentStackViewSpacing = CGFloat(16)
    let contentStackViewInset = UIEdgeInsets(all: 16)
    let completeButtonInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
}
private let constants = Constants()

final class ShortPostInfoSceneView: UIView {
    private let scrollView = UIScrollView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let completeButton = UIButton()
    
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

private extension ShortPostInfoSceneView {
    func commonInit() {
        setConstraints()
        localize()
        applyStyle()
        setUI()
    }
    
    func setConstraints() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel]).apply {
            $0.axis = .vertical
            $0.spacing = constants.contentStackViewSpacing
        }
        let contentView = UIView()
        [scrollView, completeButton].forEach(addSubview(_:))
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.width.edges.equalToSuperview()
            $0.height.equalToSuperview().priority(.low)
        }
        
        [imageView, stackView].forEach(contentView.addSubview(_:))
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(constants.contentStackViewInset)
            $0.top.equalTo(imageView.snp.bottom).offset(constants.contentStackViewInset.top)
            $0.bottom.lessThanOrEqualTo(completeButton.snp.top).offset(-constants.contentStackViewInset.bottom)
        }
        completeButton.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(safeAreaLayoutGuide).inset(constants.completeButtonInset)
        }
    }
    
    func localize() {
        completeButton.setTitle(GSln.ShortPostInfo.completeButtonTitle, for: [])
    }

    func applyStyle() {
        applyViewStyle(ViewStyleFactory.View.commonSceneBackground)
        titleLabel.applyTextStyle(TextStyleFactory.BigMessage.center)
        descriptionLabel.applyTextStyle(TextStyleFactory.Message.left)
        completeButton.applyViewStyle(ViewStyleFactory.Control.main)
    }

    func setUI() {
    }
}
