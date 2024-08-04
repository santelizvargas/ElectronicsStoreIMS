//
//  ActionButtonStyle.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/2/24.
//

import SwiftUI

private enum Constants {
    static let loginButtonBorderRadius: Double = 14
    static let buttonMaxWidth: Double = 353
}

struct ActionButtonStyle: ButtonStyle {
    private let gradientColors: [Color]
    
    init(gradientColors: [Color]) {
        self.gradientColors = gradientColors
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: Constants.buttonMaxWidth)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: Constants.loginButtonBorderRadius)
                    .foregroundStyle(
                        LinearGradient(
                            colors: gradientColors,
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing
                        )
                    )
            }
    }
}
