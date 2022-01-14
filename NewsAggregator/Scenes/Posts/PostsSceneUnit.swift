import Domain
import RxSwift
import RxCocoa

enum PostsSceneUnit: UnitType {
    typealias CellModel = PostCardUnit.ViewModel
    enum Event {
    }
    
    struct Input {
        let selectedItem: Signal<IndexPath>
    }
    
    struct Output {
        let dataSource: Driver<[CellModel]>
        let empty: Signal<Void>
    }
}

final class PostsSceneModel: ViewModelType {
    typealias Unit = PostsSceneUnit
    typealias Router = Unit.Router
    typealias Context = HasPostsUseCase & HasDateToStringConverter
    struct Configuration {
    }
    
    private let context: Context
    private let configuration: Configuration
    private let router: Unit.Router
    
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
        let errorTracker = ErrorTracker()
        
        let posts = context.postsUseCase.posts()
            .trackToDriver(errorTracker)
        
        let cellModels = posts.map(makeCellModels(for:))
        
        return Unit.Output(
            dataSource: cellModels,
            empty: .never()
        )
    }
}

// MARK: - ViewModel transform

private extension PostsSceneModel {
    private func makeCellModels(for posts: [Post]) -> [Unit.CellModel] {
        posts.map(makeCellModel(for:))
    }
    
    private func makeCellModel(for post: Post) -> Unit.CellModel {
        let config = PostCardModel.Configuration(post: post)
        let model = PostCardModel(context: context, configuration: config)
        return model.asAnyViewModel()
    }
}
