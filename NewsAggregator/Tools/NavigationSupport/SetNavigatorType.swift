import UIKit

protocol SetNavigatorType: EmptyNavigatorType {
    typealias Item = UIViewController
    
    func setItems(items: [Item], animated: Bool)
    var selectedItem: Item? { get set }
}

// MARK: - UITabBarController implement SerNavigatorType

extension UITabBarController: SetNavigatorType {
    func setItems(items: [Item], animated: Bool) {
        setViewControllers(items, animated: animated)
    }
    
    var selectedItem: Item? {
        get { selectedViewController }
        set { selectedViewController = newValue }
    }
}
