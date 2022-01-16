import UIKit
import RxSwift
import RxCocoa

final class TabBarScene: UITabBarController, ViewModelBindable {
    typealias Unit = TabBarSceneUnit
    typealias ViewModel = Unit.ViewModel
    
    var viewModel: ViewModel? {
        didSet {
            guard let model = viewModel else { return }
            bind(viewModel: model)
        }
    }
    private let disposeBag = DisposeBag()
}

// MARK: - Implement ViewModelBindable

extension TabBarScene {
    func bind(viewModel: ViewModel) {
        let input = ViewModel.Input()
        let output = viewModel.transform(input: input)
        
        disposeBag.insert(
            output.empty.emit()
        )
    }
}
