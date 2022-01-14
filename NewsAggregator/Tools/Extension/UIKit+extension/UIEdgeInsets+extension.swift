import UIKit

extension UIEdgeInsets {
    var sumV: CGFloat { top + bottom }
    var sumH: CGFloat { left + right }
    
    init(vertival: CGFloat, horizontal: CGFloat) {
        self.init(top: vertival, left: horizontal, bottom: vertival, right: horizontal)
    }
    
    init(all: CGFloat) {
        self.init(vertival: all, horizontal: all)
    }
}
