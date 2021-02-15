import XCTest
@testable import BlackBoxCore

final class DataEncryptorTests: XCTestCase {
    func testEncryption() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let dataEncryptor = BlackBoxDataEncryptor()
        let key = BlackBoxRandomGenerator().generateRandomKey(bytes: .bytes32)
        let plain = "Hello, World".utf8
        let sealedBox = try dataEncryptor.encrypt([UInt8](plain), key: key)
        
        XCTAssertTrue(sealedBox.ciphertext.count > 0)
        XCTAssertTrue(sealedBox.tag.count > 0)
        XCTAssertNotNil(sealedBox.combined)
        // we need a way to test the nonce is actually generated. currently this is a workaround
        XCTAssertTrue(sealedBox.combined!.count > (sealedBox.ciphertext.count + sealedBox.tag.count))
    }
    
    func testDecryption() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let dataEncryptor = BlackBoxDataEncryptor()
        let key = BlackBoxRandomGenerator().generateRandomKey(bytes: .bytes32)
        let plain = "Hello, World".utf8
        let sealedBox = try dataEncryptor.encrypt([UInt8](plain), key: key)
        
        let decrypted = try BlackBoxDataDecryptor().decrypt(sealedBox, key: key)
        let result = String(data: decrypted, encoding: .utf8)
        XCTAssertEqual(result, "Hello, World")
    }


    static var allTests = [
        ("testEncryption", testEncryption),
        ("testDecryption", testDecryption),
    ]
}
