import UIKit
import SnapKit

private struct Constants {
}
private let constants = Constants()

final class PostsSceneView: UIView {
    
    let tableView = UITableView()
    
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

private extension PostsSceneView {
    func commonInit() {
        setConstraints()
        localize()
        applyStyle()
        setUI()
    }
    
    func setConstraints() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func localize() {
    
    }

    func applyStyle() {
        applyViewStyle(ViewStyleFactory.View.commonSceneBackground)
    }

    func setUI() {
    }
}
