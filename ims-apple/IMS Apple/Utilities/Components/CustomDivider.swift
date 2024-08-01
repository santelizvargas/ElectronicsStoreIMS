//
//  CustomDivider.swift
//  IMS Apple
//
//  Created by Macbook Air M1 on 31/7/24.
//

import SwiftUI

struct CustomDivider: View {
    private let color: Color
    private let size: CGFloat
    
    init(color: Color = .grayBackground,
         size: CGFloat = 1) {
        self.color = color
        self.size = size
    }
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(maxWidth: .infinity, maxHeight: size)
    }
}
