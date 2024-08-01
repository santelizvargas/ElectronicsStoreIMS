//
//  Components.swift
//  IMS Apple
//
//  Created by Diana Zeledon on 31/7/24.
//

import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    private let icon: String?
    private let gradientColors: [Color]
    
    init(icon: String? = nil, gradientColors: [Color] = [.purpleGadfiente, .blueGradiente]) {
        self.icon = icon
        self.gradientColors = gradientColors
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if let icon {
                Image(systemName: icon)
            }
            configuration.label
        }
        .padding()
        .background(LinearGradient(colors: gradientColors, startPoint: .leading, endPoint: .trailing))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
