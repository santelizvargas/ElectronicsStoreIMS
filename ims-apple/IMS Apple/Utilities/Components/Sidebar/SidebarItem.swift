//
//  SidebarItem.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 31/7/24.
//

import Foundation

enum SidebarItem {
    case graphs
    case reports
    case users
    
    case productList
    case addProduct
    
    case invoiceSale
    case salesHistory
    
    case profile
    
    var name: String {
        switch self {
            case .graphs: "Gráficos"
            case .reports: "Reportes"
            case .users: "Usuarios"
                
            case .productList: "Lista de productos"
            case .addProduct: "Agregar producto"
                
            case .invoiceSale: "Facturar venta"
            case .salesHistory: "Historial de ventas"
                
            case .profile: "Perfil"
        }
    }
    
    var iconName: String {
        switch self {
            case .graphs: "chart.pie"
            case .reports: "doc.text"
            case .users: "person"
            case .productList: "list.bullet.rectangle.portrait"
            case .addProduct: "plus.circle"
            case .invoiceSale: "plus.circle"
            case .salesHistory: "doc.text.magnifyingglass"
            case .profile: "person"
        }
    }
}
