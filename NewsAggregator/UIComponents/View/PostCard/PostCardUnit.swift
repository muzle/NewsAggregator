import UIKit
import Domain
import RxSwift
import RxCocoa

enum PostCardUnit: UnitType {
    struct Input {
    }
    
    struct Output {
        let title: String?
        let sourceName: String?
        let category: String?
        let publicationDate: String?
        let withImage: Bool
        let image: Driver<UIImage?>
    }
}

// MARK: - Implement PostCardUnit.ViewModel

final class PostCardModel: ViewModelType {
    typealias Unit = PostCardUnit
    typealias Context = HasPostsUseCase & HasDateToStringConverter
    struct Configuration {
        let post: Post
    }
    
    private let context: Context
    private let configuration: Configuration
    
    init(
        context: Context,
        configuration: Configuration
    ) {
        self.context = context
        self.configuration = configuration
    }
    
    func transform(input: Unit.Input) -> Unit.Output {
        let errorTracker = ErrorTracker()
        let image = context.postsUseCase.image(for: configuration.post)
            .trackToDriver(errorTracker)
        
        return Unit.Output(
            title: configuration.post.title,
            sourceName: nil,
            category: configuration.post.category,
            publicationDate: context.dateToStringConverter.convert(configuration.post.publicationDate, commonDateFormat: .mmDDyyyyHHmm),
            withImage: configuration.post.image?.url != nil,
            image: image
        )
    }
}
