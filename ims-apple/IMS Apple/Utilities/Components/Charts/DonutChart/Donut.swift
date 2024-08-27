//
//  Donut.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 7/8/24.
//

import SwiftUI

struct Donut: Identifiable {
    let id: UUID = UUID()
    let name: String
    let value: Double
    let gradientColors: [Color]
}

// TODO: - Remove Mock Data

extension Donut {
    static let products: [Donut] = [Donut(name: "Productos", value: 1220, gradientColors: [.purpleGradient, .blueGradient])]
    static let invoices: [Donut] = [Donut(name: "Facturas", value: 124 , gradientColors: [.purpleGradient, .blueGradient])]
    
    static func getUserCount(enabled: Int, disabled: Int) -> [Donut] {
        [
            Donut(
                name: "Deshabilitados",
                value: Double(disabled),
                gradientColors: [.graySecundary, .graySecundary]
            ),
            Donut(
                name: "Habilitados",
                value: Double(enabled),
                gradientColors: [.purpleGradient, .blueGradient]
            )
        ]
    }
}
