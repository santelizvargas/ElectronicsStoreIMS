//
//  DataManagerError.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 22/7/24.
//

import Foundation

// MARK: - Data Manager Error

enum DataManagerError: Error {
    case fetchModels
    case removeModel
    
    var description: String {
        switch self {
            case .fetchModels: "Not data!"
            case .removeModel: "Data doesn't exist!"
        }
    }
}

