//
//  GradientButtonStyle.swift
//  IMS Apple
//
//  Created by Macbook Air M1 on 31/7/24.
//

import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    private let iconName: String?
    private let buttonWidth: CGFloat?
    private let gradientColors: [Color]
    
    init(iconName: String? = nil,
         buttonWidth: CGFloat? = nil,
         gradientColors: [Color] = [.purpleGradient, .blueGradient]) {
        self.iconName = iconName
        self.buttonWidth = buttonWidth
        self.gradientColors = gradientColors
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if let iconName {
                Image(systemName: iconName)
            }
            configuration.label
                .frame(maxWidth: buttonWidth)
        }
        .padding()
        .background(
            LinearGradient(
                colors: gradientColors,
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
