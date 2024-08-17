//
//  IMSResponse.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/16/24.
//

import Foundation

struct IMSResponse<Entity: Decodable>: Decodable {
    let data: Entity
}
