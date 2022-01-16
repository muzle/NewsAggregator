import UIKit
import Domain
import RxSwift
import RxCocoa

enum SettingsItemCardUnit<ViewModel>: UnitType {
    struct Input {
    }
    
    struct Output {
        let title: String
        let viewModel: ViewModel
    }
}

// MARK: - Implement SettingsItemCardUnit.ViewModel

final class SettingsItemCardModel<ViewModel>: ViewModelType {
    typealias Unit = SettingsItemCardUnit<ViewModel>
    struct Configuration {
        let title: String
        let viewModel: ViewModel
    }
    
    private let configuration: Configuration
    
    init(configuration: Configuration) {
        self.configuration = configuration
    }
    
    func transform(input: Unit.Input) -> Unit.Output {
        return Unit.Output(
            title: configuration.title,
            viewModel: configuration.viewModel
        )
    }
}
