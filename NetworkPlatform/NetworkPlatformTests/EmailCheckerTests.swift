import XCTest
@testable import NetworkPlatform

class EmailCheckerTests: XCTestCase {
    var emailChecker: EmailChecker!
    
    var validEmails = [
        "email@example.com",
        "firstname.lastname@example.com",
        "email@subdomain.example.com",
        "firstname+lastname@example.com",
        "email@123.123.123.123",
        "email@[123.123.123.123]",
        "1234567890@example.com",
        "email@example-one.com",
        "_______@example.com",
        "email@example.name",
        "email@example.museum",
        "email@example.co.jp",
        "firstname-lastname@example.com"
    ]
    
    var invalidEmails = [
        "plainaddress",
        "#@%^%#$@#$@#.com",
        "@example.com",
        "Joe Smith <email@example.com>",
        "email.example.com",
        "email@example@example.com",
        ".email@example.com",
        "email.@example.com",
        "email..email@example.com",
        "あいうえお@example.com",
        "email@example.com (Joe Smith)",
        "email@example",
        "email@-example.com",
        "email@example..com",
        "Abc..123@example.com"
    ]
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        emailChecker = EmailCheckerImpl()
    }
    
    override func tearDownWithError() throws {
        emailChecker = nil
        try super.tearDownWithError()
    }
    
    func testeCheck() {
        for text in validEmails {
            XCTAssertTrue(emailChecker.isEmail(text), text)
        }
        for text in invalidEmails {
            XCTAssertFalse(emailChecker.isEmail(text), text)
        }
    }
}
