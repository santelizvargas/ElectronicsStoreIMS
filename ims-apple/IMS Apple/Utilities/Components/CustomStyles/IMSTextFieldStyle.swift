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
    
    init(textFieldMinHeight: CGFloat = Constants.textFieldMinHeight) {
        self.textFieldMinHeight = textFieldMinHeight
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .textFieldStyle(.plain)
            .frame(minHeight: textFieldMinHeight)
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: Constants.backgroundRadius)
                    .fill(.imsGray)
            }
    }
}
