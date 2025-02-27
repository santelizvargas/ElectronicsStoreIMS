//
//  GradientButtonStyle.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 31/7/24.
//

import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    private let imageRight: String?
    private let imageLeft: String?
    private let buttonWidth: CGFloat?
    private let buttonHeight: CGFloat?
    private let gradientColors: [Color]
    private let cornerRadius: CGFloat
    
    init(imageRight: String? = nil,
         imageLeft: String? = nil,
         buttonWidth: CGFloat? = nil,
         buttonHeight: CGFloat? = 40,
         gradientColors: [Color] = [.purpleGradient, .blueGradient],
         cornerRadius: CGFloat = 12) {
        self.imageRight = imageRight
        self.imageLeft = imageLeft
        self.buttonWidth = buttonWidth
        self.buttonHeight = buttonHeight
        self.gradientColors = gradientColors
        self.cornerRadius = cornerRadius
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if let imageLeft {
                Image(systemName: imageLeft)
            }
            
            configuration.label
            
            if let imageRight {
                Image(systemName: imageRight)
            }
        }
        .padding(.horizontal)
        .frame(height: buttonHeight)
        .frame(maxWidth: buttonWidth)
        .background(
            LinearGradient(
                colors: gradientColors,
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .contentShape(Rectangle())
    }
}
