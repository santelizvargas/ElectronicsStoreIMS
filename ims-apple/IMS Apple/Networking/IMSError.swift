//
//  IMSError.swift
//  IMS Apple
//
//  Created by Jose Luna on 8/12/24.
//

import Foundation

enum IMSError: LocalizedError {
    case badUrl
    case badRequest
    case internetConnection
    case wrongCredentials
    
    var errorDescription: String {
        switch self {
            case .badUrl: "Bad URL!"
            case .badRequest: "Ops something wrong!"
            case .internetConnection: "Check your connection"
            case .wrongCredentials: "Wrong credentials"
        }
    }
}
