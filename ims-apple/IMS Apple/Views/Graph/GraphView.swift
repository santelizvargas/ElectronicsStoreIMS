//
//  GraphView.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 7/8/24.
//

import SwiftUI

private enum Constants {
    static let spacing: CGFloat = 15
    static let cornerRadius: CGFloat = 4
    static let legendSize: CGFloat = 16
    static let maxCellColumns: Int = 2
    static let imageSize: CGFloat = 60
    static let minWidth: CGFloat = 700
    static let minHeight: CGFloat = 500
}

// MARK: - Graph View

struct GraphView: View {
    @ObservedObject private var viewModel: GraphViewModel = .init()
    
    var body: some View {
        Grid(horizontalSpacing: Constants.spacing, verticalSpacing: Constants.spacing) {
            firstGridRow
            
            secondGridRow
        }
        .padding()
        .background(.grayBackground)
        .foregroundStyle(.white)
        .frame(
            minWidth: Constants.minWidth,
            maxWidth: .infinity,
            minHeight: Constants.minHeight,
            maxHeight: .infinity
        )
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                ExportPDFButton(fileName: "Graficos") { self }
            }
        }
    }
    
    // MARK: - First Row
    
    private var firstGridRow: some View {
        GridRow {
            ChartContainer(title: "Facturas") {
                DonutChart(total: viewModel.invoiceCount)
            }
            
            ChartContainer(title: "Venta de productos") {
                BarChart(data: BarItem.lastWeek)
            }
            .gridCellColumns(Constants.maxCellColumns)
            
            ChartContainer(title: "Productos") {
                DonutChart(total: viewModel.productCount)
            }
        }
    }
    
    // MARK: - Second row
    
    private var secondGridRow: some View {
        GridRow {
            ChartContainer(title: "Categorías más vendidas") {
                BarChart(data: BarItem.categories)
            }
            .gridCellColumns(Constants.maxCellColumns)
            
            usersCard
                .gridCellColumns(Constants.maxCellColumns)
        }
    }
    
    // MARK: - User Card View
    
    @ViewBuilder
    private var usersCard: some View {
        let users = Donut.getUserCount(
            enabled: viewModel.enabledUserCount,
            disabled: viewModel.disabledUserCount
        )
        
        ChartContainer(title: "Usuarios") {
            HStack(spacing: Constants.spacing) {
                DonutChart(data: users)
                
                VStack(alignment: .leading) {
                    ForEach(users) { item in
                        HStack {
                            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                                .fill(LeftGradient(colors: item.gradientColors))
                                .frame(width: Constants.legendSize, height: Constants.legendSize)
                            
                            Text(item.name)
                        }
                    }
                }
            }
        }
        .overlay(alignment: .topTrailing) {
            Image(systemName: "person.2.fill")
                .resizable()
                .scaledToFit()
                .frame(width: Constants.imageSize)
                .padding()
        }
    }
}

#Preview {
    GraphView()
}
