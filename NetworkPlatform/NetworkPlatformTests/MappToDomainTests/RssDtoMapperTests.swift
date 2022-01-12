import XCTest
@testable import NetworkPlatform
import Domain

class RssDtoMapperTests: DtoMapperTests<RssChannel, RssDtoMapperImpl> {
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mapper = .init(
            dateFormatter: Formatter.RFC822,
            emailChecker: EmailCheckerImpl(),
            resourceId: ResourceId.lenta
        )
        mappedData = RssChannel.makeStubAsInFile()
        result = .makeRssContainerStubAsInFile()
    }
}

