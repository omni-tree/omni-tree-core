// Copyright 2019 The OmniTree Authors.

import XCTest

#if !os(macOS)
  public func allTests() -> [XCTestCaseEntry] {
    return [
      testCase(JsonWireFormatEncoderTests.allTests),
    ]
  }
#endif
