import Domain
import RxSwift
import RxCocoa

enum PostsSceneUnit: UnitType {
    typealias CellModel = PostCardUnit.ViewModel
    enum Event {
        case post(Post)
    }
    
    struct Input {
        let selectedItem: Signal<IndexPath>
    }
    
    struct Output {
        let dataSource: Driver<[CellModel]>
        let updateCellFrame: Signal<(indexPath: IndexPath, isBegin: Bool)>
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
    private let updateCellFrameRelay = PublishRelay<(indexPath: IndexPath, isBegin: Bool)>()
    
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
        
        let toPostEvent = input.selectedItem
            .withLatestFrom(posts.trackToSignal(errorTracker)) { $1[$0.row] }
            .map(Unit.Event.post)
            .route(with: router)
        
        let empty = Signal.merge(toPostEvent)
        
        return Unit.Output(
            dataSource: cellModels,
            updateCellFrame: updateCellFrameRelay.asSignal(),
            empty: empty
        )
    }
}

// MARK: - ViewModel transform

private extension PostsSceneModel {
    private func makeCellModels(for posts: [Post]) -> [Unit.CellModel] {
        posts.enumerated().map(makeCellModel(for:))
    }
    
    private func makeCellModel(for postIt: EnumeratedSequence<[Post]>.Iterator.Element) -> Unit.CellModel {
        let config = PostCardModel.Configuration(post: postIt.element)
        let model = PostCardModel(
            context: context,
            configuration: config,
            router: makeCellModelRouter(with: postIt.offset)
        )
        return model.asAnyViewModel()
    }
    
    private func makeCellModelRouter(with index: Int) -> PostCardUnit.Router {
        PostCardUnit.Router { [index, updateCellFrameRelay] event in
            let indexPath = IndexPath(row: index, section: 0)
            switch event {
            case .bedinUpdateFrame:
                updateCellFrameRelay.accept((indexPath, true))
            case .endUpdateFrame:
                updateCellFrameRelay.accept((indexPath, false))
            }
        }
    }
}
