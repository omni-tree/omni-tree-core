// Copyright 2018 The OmniTree Authors.

import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(OmniTreeDataTests.allTests),
  ]
}
#endif
