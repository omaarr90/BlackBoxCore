import Foundation
import CryptoKit

public struct EncryptionResult {
    let key: SymmetricKey
    let data: Data?
    let url: URL?
}

public struct BlackBoxCore {
    
    public static func encryptFile(at url: URL,
                                   to toURL: URL,
                                   options: Data.WritingOptions = .completeFileProtectionUntilFirstUserAuthentication) throws -> EncryptionResult {
        let key = BlackBoxRandomGenerator().generateRandomKey(bytes: .bytes32)
        try BlackBoxFileEncryptor().encrypt(url, to: toURL, key: key, options: options)
        let result = EncryptionResult(key: key, data: nil, url: toURL)
        return result
    }
    
    public static func decryptFile(at url: URL,
                                   to toURL: URL,
                                   with key: SymmetricKey,
                                   options: Data.WritingOptions = .completeFileProtectionUntilFirstUserAuthentication) throws {
        try BlackBoxFileDecryptor().decrypt(url, to: toURL, key: key, options: options)
    }
    
    public static func encryptData(_ data: [UInt8]) throws -> EncryptionResult {
        let key = BlackBoxRandomGenerator().generateRandomKey(bytes: .bytes32)
        let encrypted = try BlackBoxDataEncryptor().encrypt(data, key: key)
        let result = EncryptionResult(key: key, data: encrypted.combined, url: nil)
        return result
    }
    
    public static func decrypt(_ data: [UInt8], with key: SymmetricKey) throws -> [UInt8] {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        let decrypted = try BlackBoxDataDecryptor().decrypt(sealedBox, key: key)
        return decrypted
    }
}
