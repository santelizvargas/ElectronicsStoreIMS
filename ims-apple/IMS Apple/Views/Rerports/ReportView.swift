//
//  ReportView.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 5/9/24.
//

import SwiftUI

struct ReportView: View {
    @ObservedObject private var viewModel: ReportViewModel = .init()
    @Binding private var subNavigation: String?
    @State private var selectedSection: ReportSection = .generalInventory
    @State private var showDetailView: Bool = false
    
    init(subNavigation: Binding<String?>) {
        _subNavigation = subNavigation
    }
    
    var body: some View {
        ZStack {
            if !showDetailView {
                ScrollView(showsIndicators: false) {
                    ForEach(ReportSection.allCases) { section in
                        Button {
                            selectedSection = section
                            subNavigation = section.title
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.showDetailView = true
                            }
                        } label: {
                            Text(section.title)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.secondaryBackground.opacity(0.5))
                                }
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.secondaryBackground, lineWidth: 2)
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            
            DetailViewContainer(showDetailView: $showDetailView, collection: collection) {
                buildView
            }
            #if os(macOS)
            .offset(x: showDetailView ? .zero : NSScreen.main?.frame.width ?? .zero)
            #else
            .offset(x: showDetailView ? .zero : UIScreen.main.bounds.width)
            #endif
            .animation(.spring, value: showDetailView)
        }
        .padding(20)
        .background(.grayBackground)
        .onChange(of: showDetailView) { _, isShow in
            if !isShow {
                subNavigation = nil
            }
        }
        .onDisappear {
            showDetailView = false
            subNavigation = nil
        }
    }
    
    private var collection: [Any] {
        switch selectedSection {
        case .generalInventory: viewModel.allProducts
        case .availableProducts: viewModel.availableStock
        case .outOfStockProducts: viewModel.outOfStock
        case .bestSellingCategories: viewModel.bestSellingCategories
        case .sales: viewModel.invoices
        case .weeklyProductSales: viewModel.sevenDaysAgo
        case .monthlyProductSales: viewModel.oneMonthAgo
        case .users: viewModel.users
        }
    }
    
    @ViewBuilder
    private var buildView: some View {
        switch selectedSection {
            case .generalInventory: ProductReportView(products: viewModel.allProducts)
            case .availableProducts: ProductReportView(products: viewModel.availableStock)
            case .outOfStockProducts: ProductReportView(products: viewModel.outOfStock)
            case .sales: SalesReportView(sales: viewModel.invoices)
            case .weeklyProductSales: SalesReportView(sales: viewModel.sevenDaysAgo, timeAgo: 7)
            case .monthlyProductSales: SalesReportView(sales: viewModel.oneMonthAgo, timeAgo: 30)
            case .users: UsersReportView(users: viewModel.users)
            default: Text("Testing")
//            case .bestSellingCategories:
//                <#code#>
//            case .users:
//
        }
    }
}
