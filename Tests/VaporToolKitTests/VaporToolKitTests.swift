import XCTest
@testable import VaporToolKit

final class VaporToolKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(VaporToolKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
