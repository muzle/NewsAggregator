import UIKit
import SnapKit

private struct Constants {
}
private let constants = Constants()

final class SettingsSceneView: UIView {
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

private extension SettingsSceneView {
    func commonInit() {
        setConstraints()
        applyStyle()
    }
    
    func setConstraints() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func applyStyle() {
        applyViewStyle(ViewStyleFactory.View.commonSceneBackground)
    }
}
