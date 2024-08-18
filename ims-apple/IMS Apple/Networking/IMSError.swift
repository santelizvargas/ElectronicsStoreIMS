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
    
    var localizedDescription: String {
        switch self {
            case .somethingWrong: "Ops, please try again later!"
            case .badUrl: "Bad URL!"
            case .decoding: "An error has occurred, please try again!"
        }
    }
}
