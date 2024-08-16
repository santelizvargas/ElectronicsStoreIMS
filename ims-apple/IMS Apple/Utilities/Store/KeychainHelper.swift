//
//  KeychainHelper.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/16/24.
//

import Security
import Foundation

private enum Constants {
    static let service: String = "IMS"
}

final class KeychainHelper {
    static private func makeCFDictionary(email: String,
                                  data: Data? = nil,
                                  returnData: Bool? = nil) throws -> CFDictionary {
        
        if data == nil, returnData == nil { throw IMSError.Keychain.queryError }
        
        var dictionary: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecAttrService as String: Constants.service,
        ]
        
        if let data { dictionary[kSecValueData as String] = data }
        if let returnData { dictionary[kSecReturnData as String] = returnData }
        
        return dictionary as CFDictionary
    }
    
    static func writeData(data: Data, email: String) throws -> Bool {
        let query: CFDictionary = try makeCFDictionary(email: email, data: data)
        
        let oSStatus: OSStatus = SecItemAdd(query as CFDictionary, nil)
        
        guard oSStatus == noErr else { throw IMSError.Keychain.invalidData }
        
        return true
    }
    
    static func readData(email: String) throws -> Data {
        let query: CFDictionary = try makeCFDictionary(email: email, returnData: true)
        
        var typeRef: CFTypeRef?
        
        let oSStatus = SecItemCopyMatching(query as CFDictionary, &typeRef)
        
        guard oSStatus == noErr,
              let data = typeRef as? Data else { throw IMSError.Keychain.unknownError(oSStatus) }
        
        return data
        
    }
}
