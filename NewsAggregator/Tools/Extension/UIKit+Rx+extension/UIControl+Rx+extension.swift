import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIControl {
    var tap: ControlEvent<Void> {
        controlEvent(.touchUpInside)
    }
}
