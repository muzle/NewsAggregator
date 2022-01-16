import Foundation
import Domain
import RxSwift

private struct Constants {
    let token = "0ce3ce6211a24a41aaef880d40ab08cf"
}
private let constants = Constants()

// swiftlint:disable line_length
internal class NewsApiRepository<Loader: NetworkLoader, Mapper: DtoMapper>: RootRepository<Loader>, Domain.PostsRepository where Mapper.Result == NAPostsContainer {
    private let mapper: Mapper
    
    init(loader: Loader, mapper: Mapper) {
        self.mapper = mapper
        super.init(loader: loader)
    }
    
    func posts() -> Observable<[Post]> {
        load(
            requestConvertible: NewsApiRouter.posts(query: makePostsQuery()),
            encoder: JSONEncoderFactory.commomEncoder,
            decoder: JSONDecoderFactory.dateDecoder
        )
            .map { [mapper] in try mapper.map($0)  }
            .asObservable()
            .map { $0.posts }
    }
    
    private func makePostsQuery() -> Encodable {
        NAPostsQuery(
            token: constants.token,
            country: "ru",
            category: "business",
            from: Date(),
            sort: .pubDate
        )
    }
}
// swiftlint:enable line_length
