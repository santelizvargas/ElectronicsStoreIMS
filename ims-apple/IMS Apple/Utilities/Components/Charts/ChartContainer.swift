//
//  ChartContainer.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 7/8/24.
//

import SwiftUI

private enum Constants {
    static let spacing: CGFloat = 16
    static let horizontalPadding: CGFloat = 16
    static let cornerRadius: CGFloat = 10
}

// MARK: - Chart Container View

struct ChartContainer<Content: View>: View {
    private let title: String
    private let content: Content
    
    init(title: String, @ViewBuilder _ content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: Constants.spacing) {
            Text(title)
                .font(.title2)
                .foregroundStyle(.graySecundary)
            
            content
        }
        .padding(.vertical, Constants.spacing)
        .padding(.horizontal, Constants.horizontalPadding)
        .background {
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(.secondaryBackground)
        }
    }
}

#Preview {
    ChartContainer(title: "Productos") {
        DonutChart(data: [])
    }
    .padding()
}
