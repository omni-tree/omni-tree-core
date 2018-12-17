import XCTest
@testable import OmniTreeSchema

final class OmniTreeSchemaTests: XCTestCase {
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the
    // correct results.
    XCTAssertEqual(OmniTreeSchema().text, "Hello, World!")
  }
  
  static var allTests = [
    ("testExample", testExample),
    ]
}
