import UIKit

private struct Constants {
    let imageViewInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    let contentSize = CGSize(width: 48, height: 48)
}
private let constants = Constants()

final class RoundedControl: UIControl {
    let imageView = UIImageView()
    var imageViewContentInset = constants.imageViewInset {
        didSet {
            imageView.snp.remakeConstraints {
                $0.edges.equalToSuperview().inset(imageViewContentInset)
            }
        }
    }
    private weak var preloaderView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    override var intrinsicContentSize: CGSize {
        constants.contentSize
    }
    
    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }
}

// MARK: - CommonInit

private extension RoundedControl {
    func commonInit() {
        setConstraints()
        applyStyle()
        setUI()
    }
    
    func setConstraints() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(imageViewContentInset)
        }
    }
    
    func applyStyle() {
        applyViewStyle(ViewStyleFactory.Control.roundedControl)
    }
    
    func setUI() {
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
    }
}

// MARK: - ShowPreloader

extension RoundedControl {
    func showPreloader(value: Bool) {
        imageView.isHidden = value
        if value {
            let preloader = UIActivityIndicatorView()
            addSubview(preloader)
            bringSubviewToFront(preloader)
            preloader.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
            self.preloaderView = preloader
        } else {
            preloaderView?.removeFromSuperview()
        }
    }
}
