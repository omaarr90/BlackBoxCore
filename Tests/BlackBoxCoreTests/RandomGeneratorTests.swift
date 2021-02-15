import XCTest
@testable import BlackBoxCore

final class RandomGeneratorTests: XCTestCase {
    func testGenerateRandomKey() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let generator = BlackBoxRandomGenerator()
        let key16 = generator.generateRandomKey(bytes: .bytes16)
        XCTAssertEqual(key16.bitCount, 128)
        let key32 = generator.generateRandomKey(bytes: .bytes32)
        XCTAssertEqual(key32.bitCount, 256)
        let key64 = generator.generateRandomKey(bytes: .bytes64)
        XCTAssertEqual(key64.bitCount, 512)
    }

    static var allTests = [
        ("testGenerateRandomKey", testGenerateRandomKey),
    ]
}
