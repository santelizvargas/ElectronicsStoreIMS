//
//  BlurCircle.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 7/27/24.
//

import SwiftUI

// MARK: - Local Properties

private enum Constants {
    static let primaryBlur: CGFloat = 60
    static let secondaryBlur: CGFloat = 120
    static let animationPeriod: CGFloat = 2
}

enum Position {
    case topLeading
    case topTrailing(CGSize)
    case bottomLeading(CGSize)
    case bottomTrailing(CGSize)
    
    var point: CGPoint {
        switch self {
            case .topLeading: .zero
            case .topTrailing(let size): CGPoint(x: size.width, y: .zero)
            case .bottomLeading(let size): CGPoint(x: .zero, y: size.height)
            case .bottomTrailing(let size): CGPoint(x: size.width, y: size.height)
        }
    }
}

struct BlurCircle: View {
    
    @State private var blurRadius: CGFloat = Constants.primaryBlur
    
    private let color: Color
    private let position: Position
    
    init(color: Color,
         position: Position) {
        self.color = color
        self.position = position
    }
    
    // MARK: - Body
    
    var body: some View {
        Circle()
            .fill(color)
            .blur(radius: blurRadius)
            .position(position.point)
            .animation(.linear(duration: Constants.animationPeriod).repeatForever(), value: blurRadius)
            .onAppear {
                blurRadius = Constants.secondaryBlur
            }
    }
}

// MARK: - Preview

#Preview {
    BlurCircle(color: .imsSecondary, position: .topLeading)
}
