//
//  SidebarButtonStyle.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 31/7/24.
//

import SwiftUI

// MARK: - View Constants

private enum Constants {
    static let maxHeight: CGFloat = 40
    static let cornerRadius: CGFloat = 10
    static let imageSize: CGFloat = 20
}

// MARK: - Sidebar Button Style

struct SidebarButtonStyle: ButtonStyle {
    private let iconName: String?
    private let isSelected: Bool
    
    init(iconName: String? = nil, isSelected: Bool) {
        self.iconName = iconName
        self.isSelected = isSelected
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if let iconName {
                Image(systemName: iconName)
                    .resizable()
                    .frame(
                        width: Constants.imageSize,
                        height: Constants.imageSize
                    )
            }
            
            configuration.label
        }
        .buttonStyle(.plain)
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .frame(height: Constants.maxHeight)
        .padding(.horizontal)
        .background {
            if isSelected {
                LinearGradient(
                    colors: [
                        .purpleGradient,
                        .blueGradient
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
        .contentShape(Rectangle())
    }
}

