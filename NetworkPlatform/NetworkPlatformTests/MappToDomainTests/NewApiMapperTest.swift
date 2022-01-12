import Foundation
@testable import NetworkPlatform
import Domain

class NewsApiDtoMapperTests: DtoMapperTests<NAPostsContainer, NewsApiDtoMapper> {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mapper = .init(
            resourceId: ResourceId.newApi,
            imageUrl: nil,
            name: nil,
            title: nil,
            description: nil,
            resourceURL: .init(string: "https://newsapi.org")
        )
        mappedData = .makeStubAsInFile()
        result = .makeNewApiContainerStubAsInFile()
    }
}
