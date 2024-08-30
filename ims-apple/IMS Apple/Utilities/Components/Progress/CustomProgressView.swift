//
//  CustomProgressView.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 20/8/24.
//

import SwiftUI

private enum Constants {
    static let circleSize: CGFloat = 10
    static let animationDuration: Double = 1
    static let maxDegrees: Double = 360
    static let containerSize: Double = 50
}

struct CustomProgressView: View {
    @State private var rotationDegrees: CGFloat = .zero
    
    var body: some View {
        VStack {
            createRow(with: [.red, .yellow])
            Spacer()
            createRow(with: [.green, .blue])
        }
        .frame(width: Constants.containerSize, height: Constants.containerSize)
        .rotationEffect(.degrees(rotationDegrees))
        .onAppear {
            startRotationAnimation()
        }
        .onDisappear {
            rotationDegrees = .zero
        }
    }
    
    private func createRow(with colors: [Color]) -> some View {
        HStack {
            ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
                Circle()
                    .fill(color)
                    .frame(width: Constants.circleSize)
                
                if index == .zero {
                    Spacer()
                }
            }
        }
    }
    
    private func startRotationAnimation() {
        withAnimation(.easeInOut(
            duration: Constants.animationDuration
        ).repeatForever(autoreverses: false)) {
            rotationDegrees = Constants.maxDegrees
        }
    }
}

