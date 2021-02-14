import XCTest

import BlackBoxCoreTests

var tests = [XCTestCaseEntry]()
tests += BlackBoxCoreTests.allTests()
XCTMain(tests)
