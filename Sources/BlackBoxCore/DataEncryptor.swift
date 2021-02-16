//
//  DataEncryptor.swift
//  
//
//  Created by Omar Alshammari on 03/07/1442 AH.
//

import Foundation
import CryptoKit

public protocol DataEncryptor {
    func encrypt(_ plain: [UInt8],
                 key: SymmetricKey) throws -> AES.GCM.SealedBox
}

public protocol DataDecryptor {
    func decrypt(_ sealed: AES.GCM.SealedBox,
                 key: SymmetricKey) throws -> [UInt8]
}

public struct BlackBoxDataEncryptor: DataEncryptor {
    public func encrypt(_ plain: [UInt8],
                        key: SymmetricKey) throws -> AES.GCM.SealedBox {
        let encrypted = try AES.GCM.seal(plain, using: key)
        return encrypted
    }
}

public struct BlackBoxDataDecryptor: DataDecryptor {
    public func decrypt(_ sealed: AES.GCM.SealedBox,
                        key: SymmetricKey) throws -> [UInt8] {
        let decrypted = try AES.GCM.open(sealed, using: key)
        return [UInt8](decrypted)
    }
}
