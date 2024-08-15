//
//  SidebarSection.swift
//  IMS Apple
//
//  Created by Macbook Air M1 on 31/7/24.
//

import Foundation

enum SidebarSection: CaseIterable {
    case dashboard
    case inventory
    case invoicing
    
    var name: String {
        switch self {
        case .dashboard: "Dashboard"
        case .inventory: "Inventario"
        case .invoicing: "Facturación"
        }
    }
    
    var itemList: [SidebarItem] {
        switch self {
        case .dashboard: [.graphs, .users]
        case .inventory: [.productList, .addProduct]
        case .invoicing: [.invoiceSale, .salesHistory]
        }
    }
}
