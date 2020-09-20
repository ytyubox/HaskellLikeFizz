import XCTest

import HaskellLikeFizzTests

var tests = [XCTestCaseEntry]()
tests += HaskellLikeFizzTests.allTests()
XCTMain(tests)
