import XCTest

import OmniTreeSchemaTests
import OmniTreeDataTests

var tests = [XCTestCaseEntry]()
tests += OmniTreeSchemaTests.allTests()
tests += OmniTreeDataTests.allTests()
XCTMain(tests)
