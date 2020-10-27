import XCTest
@testable import GitList

final class GitListTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GitList().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
