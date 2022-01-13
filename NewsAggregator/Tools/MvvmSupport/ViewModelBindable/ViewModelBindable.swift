import Foundation

protocol ViewModelBindable {
    associatedtype ViewModel
    func bind(viewModel: ViewModel)
}
