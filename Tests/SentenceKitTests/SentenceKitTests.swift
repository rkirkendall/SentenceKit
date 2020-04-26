import XCTest
@testable import SentenceKit

final class SentenceKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SentenceKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
