//
//  BarChart.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 7/8/24.
//

import SwiftUI
import Charts

private enum Constants {
    static let prefix: Int = 3
    static let cornerRadius: CGFloat = 5
    static let horizontalPadding: CGFloat = 30
}

// MARK: - Bar Chart View

struct BarChart: View {
    @State private var offset: CGPoint = .zero
    @State private var selectedName: String = ""
    @State private var selectedValue: Int = .zero
    @State private var showPopover: Bool = false
    
    private let data: [BarItem]
    
    init(data: [BarItem]) {
        self.data = data
    }
    
    var body: some View {
        Chart(data) { item in
            BarMark(
                x: .value("id", item.id.uuidString),
                y: .value("value", item.value)
            )
            .foregroundStyle(LeftGradient(colors: [.purpleGradient, .blueGradient]))
            .cornerRadius(Constants.cornerRadius)
        }
        .chartXAxis {
            AxisMarks { value in
                AxisValueLabel {
                    if let id = value.as(String.self),
                       let values = data.first(where: { $0.id.uuidString == id}) {
                        Text(values.name.prefix(Constants.prefix))
                    }
                }
            }
        }
        .chartOverlay { proxy in
            GeometryReader { geometry in
                Rectangle()
                    .fill(.clear)
                    .contentShape(Rectangle())
                    .onTapGesture { location in
                        if let (id, _) = proxy.value(at: location, as: (String, Double).self),
                           let selectedItem = data.first(where: { $0.id.uuidString == id }) {
                            selectedName = selectedItem.name
                            selectedValue = Int(selectedItem.value)
                            offset = location
                            showPopover = true
                        }
                    }
                    .popover(isPresented: $showPopover,
                             attachmentAnchor: .point(calculateUnitPoint(geometry.size)),
                             arrowEdge: .trailing) {
                        popoverView
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Popover View
    
    private var popoverView: some View {
        VStack {
            customRow(label: "Nombre:", value: selectedName)
            
            CustomDivider(color: .white)
            
            customRow(label: "Valor:", value: selectedValue.description)
        }
        .padding(.vertical)
        .padding(.horizontal, Constants.horizontalPadding)
    }
    
    // MARK: - Custom Row View
    
    private func customRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
            
            Text(value)
        }
        .font(.title3.bold())
        .foregroundStyle(.white)
    }
    
    private func calculateUnitPoint(_ size: CGSize) -> UnitPoint {
        UnitPoint(x: offset.x / size.width, y: offset.y / size.height)
    }
}

#Preview {
    BarChart(data: BarItem.categories)
        .padding()
}
