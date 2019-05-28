import XCTest

import OmniTreeCodecsTests
import OmniTreeDataTests
import OmniTreeSchemaTests

var tests = [XCTestCaseEntry]()
tests += OmniTreeSchemaTests.allTests()
tests += OmniTreeDataTests.allTests()
tests += OmniTreeCodecsTests.allTests()
XCTMain(tests)
