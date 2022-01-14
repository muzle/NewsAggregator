import XCTest
@testable import NewsAggregator
import Domain
import RxBlocking

class PostCardUnitModelTests: XCTestCase {
    
    var model: PostCardUnit.ViewModel!
    
    lazy var postStub = Post(
        id_: "postId",
        author_: nil,
        link_: nil,
        publicationDate_: Date(),
        title_: "title",
        description_: "description",
        category_: "category",
        image_: nil
    )
    let dateResult = "22:02"
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let config = PostCardModel.Configuration(post: postStub)
        let context = Context(
            dateToStringConverter: DateToStringConverterMock(result: dateResult),
            postsUseCase: PostsUseCaseMock(posts: [], image: nil)
        )
        let model = PostCardModel(context: context, configuration: config)
        self.model = model.asAnyViewModel()
    }

    override func tearDownWithError() throws {
        model = nil
        try super.tearDownWithError()
    }

    func testOutput() throws {
        let input = PostCardUnit.Input()
        let output = model.transform(input: input)
        XCTAssertEqual(output.title, postStub.title)
        XCTAssertEqual(output.category, postStub.category)
        XCTAssertFalse(output.withImage)
        XCTAssertEqual(output.publicationDate, dateResult)
        XCTAssertNil(output.sourceName)
        XCTAssertNil(try output.image.toBlocking().first()!)
    }
    
    struct Context: PostCardModel.Context {
        var dateToStringConverter: DateToStringConverter
        var postsUseCase: PostsUseCase
    }
}
