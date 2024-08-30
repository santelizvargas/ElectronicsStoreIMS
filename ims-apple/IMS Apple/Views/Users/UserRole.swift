//
//  UserRole.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 26/8/24.
//

import Foundation

enum UserRole: Int, CaseIterable, Identifiable {
    case owner = 1
    case admin = 2
    case seller = 3
    case supplier = 4
    
    var id: Int { rawValue }
    
    var name: String {
        switch self {
            case .seller: "Vendedor"
            case .supplier: "Abastecedor"
            default: String(describing: self).capitalized
        }
    }
    
    static func getRoles(omit: UserRole) -> [UserRole] {
        UserRole.allCases.filter { role in
            role != .owner &&
            role != omit
        }
    }
}

