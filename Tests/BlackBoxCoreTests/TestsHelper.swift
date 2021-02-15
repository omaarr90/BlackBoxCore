//
//  File.swift
//  
//
//  Created by Omar Alshammari on 03/07/1442 AH.
//

import Foundation
import XCTest

public func XCTAssertThrowsError<T, E: Error & Equatable>(
    _ expression: @autoclosure () throws -> T,
    expectedError: E,
    _ message: String = "",
    file: StaticString = #file,
    line: UInt = #line) {

    XCTAssertThrowsError(try expression(), message, file: file, line: line, { (error) in
        XCTAssertNotNil(error as? E, "\(error) is not \(E.self)", file: file, line: line)
        XCTAssertEqual(error as? E, expectedError, file: file, line: line)
    })
}

public func XCTAssertThrowsError<T, E: Error>(
    _ expression: @autoclosure () throws -> T,
    expectedErrorType: E.Type,
    _ message: String = "",
    file: StaticString = #file,
    line: UInt = #line) {

    XCTAssertThrowsError(try expression(), message, file: file, line: line, { (error) in
        XCTAssertNotNil(error as? E, "\(error) is not \(E.self)", file: file, line: line)
    })
}
