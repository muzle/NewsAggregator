import UIKit
import Domain
import RxSwift
import RxCocoa

enum PostCardUnit: UnitType {
    enum Event {
    }
    
    struct Input {
    }
    
    struct Output {
        let empty: Signal<Void>
    }
}

// MARK: - Implement PostCardUnit.ViewModel

final class PostCardModel: ViewModelType {
    typealias Unit = PostCardUnit
    typealias Router = Unit.Router
    typealias Context = NoContext
    struct Configuration {
    
    }
    
    private let context: Context
    private let configuration: Configuration
    private let router: Router
    
    init(
        context: Context,
        configuration: Configuration,
        router: Router
    ) {
        self.context = context
        self.configuration = configuration
        self.router = router
    }
    
    func transform(input: Unit.Input) -> Unit.Output {
        return Unit.Output(
            empty: .never()
        )
    }
}
