import UIKit

private struct Constants {
    let contentInset = UIEdgeInsets.zero
    let minScaleX = 0.97
    let maxScaleX = 1.0
    let minScaleY = 0.97
    let maxScaleY = 1.0
    let animationDuration = 0.3
}
private let constants = Constants()

class TableViewWrapperCell<ContentView: UIView>: UITableViewCell {
    lazy var cellContentView = ContentView(frame: bounds)
    var useAnimation = true
    var cellContentViewInset = constants.contentInset {
        willSet {
            guard newValue != cellContentViewInset else { return }
            cellContentView.snp.remakeConstraints {
                $0.edges.equalToSuperview().inset(newValue)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        (self as? ReactiveReusable)?.reuse()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        animataTouch(down: highlighted)
        super.setHighlighted(highlighted, animated: animated)
    }
    
    private func commonInit() {
        selectionStyle = .none
        contentView.addSubview(cellContentView)
        cellContentView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(cellContentViewInset)
        }
    }
    
    private func animataTouch(down value: Bool) {
        guard useAnimation else { return }
        let scaleX = value ? constants.minScaleX : constants.maxScaleX
        let scaleY = value ? constants.minScaleY : constants.maxScaleY
        UIView.animate(withDuration: constants.animationDuration) { [cellContentView] in
            cellContentView.transform = .init(scaleX: scaleX, y: scaleY)
        }
    }
}

// MARK: - Implement ViewModelBindable

extension TableViewWrapperCell: ViewModelBindable where ContentView: ViewModelBindable {
    typealias ViewModel = ContentView.ViewModel
    
    func bind(viewModel: ViewModel) {
        cellContentView.bind(viewModel: viewModel)
    }
}

// MARK: - Implement ReactiveReuable

extension TableViewWrapperCell: ReactiveReusable where ContentView: ReactiveReusable {
    func reuse() {
        cellContentView.reuse()
    }
}
