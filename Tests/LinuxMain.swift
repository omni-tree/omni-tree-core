import XCTest

import OmniTreeDataTests
import OmniTreeSchemaTests

var tests = [XCTestCaseEntry]()
tests += OmniTreeSchemaTests.allTests()
tests += OmniTreeDataTests.allTests()
XCTMain(tests)
