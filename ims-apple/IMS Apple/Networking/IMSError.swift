//
//  IMSError.swift
//  IMS Apple
//
//  Created by Jose Luna on 8/12/24.
//

import Foundation

enum IMSError: Error {
    
    enum HTTP: Error {
        case badUrl
        case requestError
        case badResponse(Int)
        
        var description: String {
            switch self {
                case .badUrl: "Bad URL!"
                case .requestError: "An error has occurred!"
                case .badResponse(let statusCode):
                    switch statusCode {
                        case 200...299: "Success"
                        case 400...500: "Wrong credentials!"
                        case 500...503: "Check your internet connection"
                        default: "Ops something wrong!"
                    }
            }
        }
    }
    
    enum Keychain: Error {
        case invalidData
        case queryError
        case unknownError(OSStatus)
        
        var description: String {
            switch self {
                case .invalidData: "Invalid data!"
                case .queryError: "Make a valid query!"
                case .unknownError(let oSStatus): "Not saved by status: \(oSStatus)"
            }
        }
    }
}
