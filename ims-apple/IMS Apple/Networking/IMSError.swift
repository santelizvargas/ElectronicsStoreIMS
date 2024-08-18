//
//  IMSError.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/12/24.
//

import Foundation

enum IMSError: Error {
    
    ///  JSONDecoder
    case decoding
    
    /// HTTPS
    case somethingWrong
    case badUrl
    
    /// Keychain
    case invalidData
    case queryError
    case unknownError(OSStatus)
    
    var localizedDescription: String {
        switch self {
            case .somethingWrong: "Ops, please try again later!"
            case .badUrl: "Bad URL!"
            case .invalidData: "Invalid data!"
            case .queryError: "Make a valid query!"
            case .unknownError(let oSStatus): "Not saved by status: \(oSStatus)"
            case .decoding: "An error has occurred, please try again!"
        }
    }
}
