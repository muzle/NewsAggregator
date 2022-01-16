import UIKit
import Domain
import RxSwift
import RxCocoa

enum PostCardUnit: UnitType {
    enum Event {
        case bedinUpdateFrame
        case endUpdateFrame
    }
    
    struct Input {
    }
    
    struct Output {
        let title: String?
        let sourceName: String?
        let category: String?
        let publicationDate: String?
        let withImage: Bool
        let image: Driver<UIImage?>
        let watchCount: Driver<String>
        let watchCountLabelIsHidden: Driver<Bool>
        let empty: Signal<Void>
    }
}

// MARK: - Implement PostCardUnit.ViewModel

final class PostCardModel: ViewModelType {
    typealias Unit = PostCardUnit
    typealias Router = Unit.Router
    typealias Context = HasPostsUseCase & HasDateToStringConverter
    struct Configuration {
        let post: Post
    }
    
    private let context: Context
    private let router: Router
    private let configuration: Configuration
    
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
        let image = context.postsUseCase.image(for: configuration.post)
            .trackToDriver(errorTracker)
        let watchCount = context.postsUseCase.numberOfVisit(post: configuration.post)
            .trackToDriver(errorTracker)
        let watchCountLabelIsHidden = watchCount
            .map { $0 <= 0 }

        let updateFrameEvent = watchCountLabelIsHidden
            .distinctUntilChanged()
            .skip(1)
            .mapToVoid()
            .do(
                onNext: { [router] in router.handle(event: .bedinUpdateFrame) },
                afterNext: { [router] in router.handle(event: .endUpdateFrame) }
            )
            .trackToSignal(errorTracker)
        
        return Unit.Output(
            title: configuration.post.title,
            sourceName: nil,
            category: configuration.post.category,
            publicationDate: context.dateToStringConverter.convert(configuration.post.publicationDate, commonDateFormat: .mmDDyyyyHHmm),
            withImage: configuration.post.image?.url != nil,
            image: image,
            watchCount: watchCount.map(makeWatchCountText),
            watchCountLabelIsHidden: watchCountLabelIsHidden,
            empty: updateFrameEvent
        )
    }
    
    private func makeWatchCountText(count: Int) -> String {
        "\(count)"
    }
}
