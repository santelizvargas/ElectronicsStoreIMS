//
//  ProductCategory.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 13/8/24.
//

import Foundation

enum ProductCategory: CaseIterable {
    case all
    case computers
    case phones
    case televisions
    case cameras
    case appliances
    case games
    case networking
    case printers
    case security
    case electronicParts
    
    var title: String {
        switch self {
            case .all: "Todas"
            case .computers: "Computadoras"
            case .phones: "Teléfonos"
            case .televisions: "Televisores"
            case .cameras: "Cámaras"
            case .appliances: "Electrodomésticos"
            case .games: "Consolas y Juegos"
            case .networking: "Redes"
            case .printers: "Impresoras"
            case .security: "Seguridad"
            case .electronicParts: "Repuestos"
        }
    }
    
    static var categories: [ProductCategory] {
        ProductCategory.allCases.filter { $0 != .all }
    }
}
