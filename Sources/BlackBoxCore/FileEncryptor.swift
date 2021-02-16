//
//  FileEncryptor.swift
//  
//
//  Created by Omar Alshammari on 04/07/1442 AH.
//

import Foundation
import CryptoKit

public enum FileEncryptorError: Error {
    case notFile
    case noContents
}

public protocol FileEncryptor {
    func encrypt(_ url: URL,
                 to toURL: URL,
                 key: SymmetricKey,
                 options: Data.WritingOptions) throws
}

public protocol FileDecryptor {
    func decrypt(_ url: URL,
                 to toURL: URL,
                 key: SymmetricKey,
                 options: Data.WritingOptions) throws
}

public struct BlackBoxFileEncryptor: FileEncryptor {
    public func encrypt(_ url: URL,
                        to toURL: URL,
                        key: SymmetricKey,
                        options: Data.WritingOptions = .completeFileProtectionUntilFirstUserAuthentication) throws {
        guard url.isFileURL, toURL.isFileURL else {
            throw FileEncryptorError.notFile
        }
        guard let contents = FileManager.default.contents(atPath: url.path) else {
            throw FileEncryptorError.noContents
        }
        let encrypted = try BlackBoxDataEncryptor().encrypt([UInt8](contents), key: key)
        try encrypted.combined?.write(to: toURL, options: options)
    }
}

public struct BlackBoxFileDecryptor: FileDecryptor {
    public func decrypt(_ url: URL,
                        to toURL: URL,
                        key: SymmetricKey,
                        options: Data.WritingOptions = .completeFileProtectionUntilFirstUserAuthentication) throws {
        guard url.isFileURL, toURL.isFileURL else {
            throw FileEncryptorError.notFile
        }
        guard let contents = FileManager.default.contents(atPath: url.path) else {
            throw FileEncryptorError.noContents
        }
        let sealed = try AES.GCM.SealedBox(combined: contents)
        let open = try BlackBoxDataDecryptor().decrypt(sealed, key: key)
        let data = Data(open)
        try data.write(to: toURL, options: options)
        fatalError()
    }
}
