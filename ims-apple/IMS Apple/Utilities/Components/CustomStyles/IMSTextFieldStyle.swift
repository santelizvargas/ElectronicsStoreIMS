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
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .textFieldStyle(.plain)
            .frame(minHeight: Constants.textFieldMinHeight)
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: Constants.backgroundRadius)
                    .fill(.imsGray)
            }
    }
}
