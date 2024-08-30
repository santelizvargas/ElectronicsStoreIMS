//
//  LeftGradient.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/8/24.
//

import SwiftUI

struct LeftGradient: ShapeStyle {
    private let colors: [Color]
    
    init(colors: [Color]) {
        self.colors = colors
    }
    
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        LinearGradient(
            colors: colors,
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}
