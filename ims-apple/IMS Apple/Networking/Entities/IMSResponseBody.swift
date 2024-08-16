//
//  IMSResponse.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/16/24.
//

struct IMSResponseBody<Entity: Codable>: Codable {
    let accessToken: String
    let expiresIn: Int
    let data: Entity
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case expiresIn = "expiresIn"
        case data
    }
}
