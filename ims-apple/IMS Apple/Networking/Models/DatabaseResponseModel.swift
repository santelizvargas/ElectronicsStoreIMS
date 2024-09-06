//
//  DatabaseResponseModel.swift
//  IMS Apple
//
//  Created by Derian Córdoba on 5/9/24.
//

import Foundation

struct DatabaseResponseModel: Decodable {
    let message: String
    let code: Int
}

struct ListDatabaseResponseModel: Decodable {
    let data: [String]
}
