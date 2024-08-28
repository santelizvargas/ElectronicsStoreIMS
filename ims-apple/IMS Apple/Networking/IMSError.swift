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
    case badPassword
    case sameAsLastPassword
    
    /// HTTPS
    case somethingWrong
    case badUrl
    
    /// Products
    case uniqueNameKey
    case productNotFound
    
    // TODO: - Translate the error messages to Spanish language
    
    var localizedDescription: String {
        switch self {
            case .somethingWrong: "Ops, please try again later"
            case .badUrl: "Bad URL"
            case .decoding: "An error has occurred, please try again"
            case .badPassword: "Wrong credentials"
            case .sameAsLastPassword: "New password must be different"
            case .uniqueNameKey: "Product name exists, please provide another"
            case .productNotFound: "Product not found"
        }
    }
}
