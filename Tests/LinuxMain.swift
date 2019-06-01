import XCTest

import OmniTreeCodecsTests
import OmniTreeDataTests

var tests = [XCTestCaseEntry]()
tests += OmniTreeDataTests.allTests()
tests += OmniTreeCodecsTests.allTests()
XCTMain(tests)
