//
//  SidebarSection.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 31/7/24.
//

import Foundation

enum SidebarSection: CaseIterable {
    case user
    case dashboard
    case inventory
    case invoicing
    
    var name: String {
        switch self {
            case .dashboard: "Dashboard"
            case .inventory: "Inventario"
            case .invoicing: "Facturación"
            case .user: "Usuario"
        }
    }
    
    var itemList: [SidebarItem] {
        switch self {
            case .dashboard: [.graphs, .users]
            case .inventory: [.productList, .addProduct]
            case .invoicing: [.invoiceSale, .salesHistory]
            case .user: [.profile]
        }
    }
    
    static func getSidebarCases(role: UserRole) -> [SidebarSection] {
        switch role {
            case .seller: [.user, .invoicing]
            case .supplier: [.user, .inventory]
            default: SidebarSection.allCases
        }
    }
}
