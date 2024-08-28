//
//  ProductCategory.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 13/8/24.
//

import Foundation

enum ProductCategory: String, CaseIterable {
    case all = "Todas"
    case computers = "Computadoras"
    case phones = "Teléfonos"
    case televisions = "Televisores"
    case cameras = "Cámaras"
    case appliances = "Electrodomésticos"
    case games = "Consolas y Juegos"
    case networking = "Redes"
    case printers = "Impresoras"
    case security = "Seguridad"
    case electronicParts = "Repuestos"
    
    static var categories: [ProductCategory] {
        ProductCategory.allCases.filter { $0 != .all }
    }
}

