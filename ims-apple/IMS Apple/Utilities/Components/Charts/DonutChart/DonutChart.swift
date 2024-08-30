//
//  DonutChart.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 7/8/24.
//

import SwiftUI
import Charts

// MARK: - View Constants

private enum Constants {
    static let spacerValue: Double = 0.01
    static let minCount: Int = 1
    
    enum Chart {
        static let ratio: CGFloat = 0.7
        static let angularInset: CGFloat = 2
        static let cornerRadius: CGFloat = 5
        static let degrees: CGFloat = 50
    }
    
    static func getSpacerItem(_ value: Double?) -> [Donut] {
        let value = (value ?? .zero) * Constants.spacerValue
        return [
            Donut(
                name: "Spacer",
                value: value,
                gradientColors: [.clear]
            )
        ]
    } 
    
    static func getDefaultItems(_ total: Double) -> [Donut] {
        let value = total * Constants.spacerValue
        return [
            Donut(
                name: "Spacer",
                value: value,
                gradientColors: [.clear]
            ),
            Donut(
                name: "Default",
                value: total,
                gradientColors: [.purpleGradient, .blueGradient]
            )
        ]
    }
}

// MARK: - Donut Chart View

struct DonutChart: View {
    private let data: [Donut]
    private let total: Double
    
    init(data: [Donut] = [], total: Int? = nil) {
        if let total {
            self.total = Double(total)
            self.data = Constants.getDefaultItems(Double(total))
        } else {
            self.total = data.map { $0.value }.reduce(.zero, +)
            self.data = data.count > Constants.minCount ?
            data : data + Constants.getSpacerItem(data.first?.value)
        }
    }
    
    var body: some View {
        Chart(data) { item in
            SectorMark(
                angle: .value("name", item.value),
                innerRadius: .ratio(Constants.Chart.ratio),
                angularInset: Constants.Chart.angularInset
            )
            .cornerRadius(Constants.Chart.cornerRadius)
            .foregroundStyle(LeftGradient(colors: item.gradientColors))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .rotationEffect(.degrees(Constants.Chart.degrees))
        .chartBackground { _ in
            Text(Int(total).description)
                .font(.largeTitle)
        }
        .overlay {
            if total == .zero {
                CustomProgressView()
            }
        }
    }
}

#Preview {
    DonutChart(data: [])
}
