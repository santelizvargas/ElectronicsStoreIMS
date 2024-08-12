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
}

// MARK: - Graph View

struct GraphView: View {
    var body: some View {
        PDFExporterContainer(fileName: "Charts", content: {
            Grid(horizontalSpacing: Constants.spacing,
                 verticalSpacing: Constants.spacing) {
                firstGridRow
                
                secondGridRow
            }
            .padding()
            .background(.grayBackground)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        })
    }
    
    // MARK: - First Row
    
    private var firstGridRow: some View {
        GridRow {
            ChartContainer(title: "Facturas") {
                DonutChart(data: Donut.invoices)
            }
            
            ChartContainer(title: "Venta de productos") {
                BarChart(data: BarItem.lastWeek)
            }
            .gridCellColumns(Constants.maxCellColumns)
            
            ChartContainer(title: "Productos") {
                DonutChart(data: Donut.products)
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
    
    private var usersCard: some View {
        ChartContainer(title: "Usuarios") {
            HStack(spacing: Constants.spacing) {
                DonutChart(data: Donut.users)
                
                VStack(alignment: .leading) {
                    ForEach(Donut.users) { item in
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
