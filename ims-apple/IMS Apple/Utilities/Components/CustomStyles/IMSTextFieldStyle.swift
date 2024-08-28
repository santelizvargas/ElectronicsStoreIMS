//
//  IMSTextFieldStyle.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 7/30/24.
//

import SwiftUI

private enum Constants {
    static let textFieldMinHeight: CGFloat = 30
    static let backgroundRadius: Double = 8
}

struct IMSTextFieldStyle: TextFieldStyle {
    private let textFieldMinHeight: CGFloat
    private let isActive: Bool
    
    init(textFieldMinHeight: CGFloat = Constants.textFieldMinHeight, isActive: Bool = true) {
        self.textFieldMinHeight = textFieldMinHeight
        self.isActive = isActive
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .textFieldStyle(.plain)
            .frame(minHeight: textFieldMinHeight)
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: Constants.backgroundRadius)
                    .fill(isActive ? .imsGray : .imsDesactive)
            }
    }
}
