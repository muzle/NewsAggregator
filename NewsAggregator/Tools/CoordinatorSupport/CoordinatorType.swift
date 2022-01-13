import UIKit

public protocol CoordinatorType {
    func makeScene() -> UIViewController
    
    func setScene()
}

extension CoordinatorType {
    func setScene() {
        #if DEBUG
        preconditionFailure("setScene() has not been implemented")
        #endif
    }
}
