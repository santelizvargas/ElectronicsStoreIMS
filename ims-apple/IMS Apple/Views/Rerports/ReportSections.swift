//
//  ReportSections.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 5/9/24.
//

import Foundation

enum ReportSection: CaseIterable, Identifiable {
    case generalInventory
    case availableProducts
    case outOfStockProducts
    case bestSellingCategories
    case sales
    case weeklyProductSales
    case monthlyProductSales
    case users
    
    var id: String { String(describing: self) }
    
    var title: String {
        switch self {
            case .generalInventory: "Inventario general"
            case .availableProducts: "Stock disponible"
            case .outOfStockProducts: "Stock no disponible"
            case .bestSellingCategories: "Top categorías de ventas"
            case .weeklyProductSales: "Ventas de la última semana"
            case .monthlyProductSales: "Ventas del último mes"
            case .users: "Gestión de usuarios"
            case .sales: "Reporte de ventas"
        }
    }
}
