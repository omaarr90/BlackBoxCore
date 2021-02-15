//
//  RandomGenerator.swift
//  
//
//  Created by Omar Alshammari on 03/07/1442 AH.
//

import Foundation
import CryptoKit

public protocol RandomGenerator {
    func generateRandomKey(bytes: BlackBoxRandomGenerator.KeySize) -> SymmetricKey
}

public struct BlackBoxRandomGenerator: RandomGenerator {
    
    public enum KeySize: Int {
        case bytes16 = 128
        case bytes32 = 256
        case bytes64 = 512
    }
    
    public func generateRandomKey(bytes: KeySize) -> SymmetricKey {
        let size = SymmetricKeySize(bitCount: bytes.rawValue)
        let key = SymmetricKey(size: size)
        return key
    }
}
