//
//  ProductState.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 13/8/24.
//

import Foundation

enum ProductState: CaseIterable {
    case all, outOfStock, available
    
    var title: String {
        switch self {
            case .all: "Todos"
            case .outOfStock: "Agotado"
            case .available: "Disponible"
        }
    }
}
