import Foundation
@testable import NetworkPlatform
import Domain

class NewsApiDtoMapperTests: DtoMapperTests<NAPostsContainer, NewsApiDtoMapper> {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mapper = .init(
            encoder: JSONEncoderFactory.yyyyMMddDateSupportEncoder,
            resourceInfo: PostsResourceInfoFactory.newsApi,
            shaService: SHA256()
        )
        
        mappedData = .makeStubAsInFile()
        result = .makeNewApiContainerStubAsInFile()
    }
}
