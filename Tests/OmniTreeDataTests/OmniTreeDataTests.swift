// Copyright 2018 The OmniTree Authors.

import XCTest
@testable import OmniTreeData

final class OmniTreeDataTests: XCTestCase {
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the
    // correct results.
    XCTAssertEqual(OmniTreeData().text, "Hello, World!")
  }

  static var allTests = [
    ("testExample", testExample),
    ]
}
