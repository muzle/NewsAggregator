import XCTest
@testable import NetworkPlatform
import Domain

class RssDtoMapperTests: DtoMapperTests<RssChannel, RssDtoMapperImpl> {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mapper = .init(
            dateFormatter: .RFC822,
            encoder: JSONEncoderFactory.commomEncoder,
            emailChecker: EmailCheckerImpl(),
            resourceInfo: PostsResourceInfoFactory.lenta,
            shaService: SHA256()
        )
        
        mappedData = RssChannel.makeStubAsInFile()
        result = .makeRssContainerStubAsInFile()
    }
}

