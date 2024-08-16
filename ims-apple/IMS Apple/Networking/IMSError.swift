//
//  IMSError.swift
//  IMS Apple
//
//  Created by Jose Luna on 8/12/24.
//

import Foundation

enum IMSError: Error {
    case badUrl
    case requestError
    case HTTPError(Int)
    
    var description: String {
        switch self {
            case .badUrl: "Bad URL!"
            case .requestError: "An error has occurred!"
            case .HTTPError(let statusCode):
                switch statusCode {
                    case 200...299: "Success"
                    case 400...500: "Wrong credentials!"
                    case 500...503: "Check your internet connection"
                    default: "Ops something wrong!"
                }
        }
    }
}
