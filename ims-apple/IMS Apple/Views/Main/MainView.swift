//
//  MainView.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 17/7/24.
//

import SwiftUI

private enum Constants {
    static let screenMinWidth: CGFloat = 700
    static let screenMinHeight: CGFloat = 500
    static let macOSButtonHeight: CGFloat = 35
    static let iOSButtonHeight: CGFloat = 35
}

struct MainView: View {
    @State private var itemSelected: SidebarItem = .profile
    @State private var subNavigation: String?
    @Binding private var navigationPath: NavigationPath
    @ObservedObject private var viewModel: MainViewViewModel = MainViewViewModel()
    
    init(navigationPath: Binding<NavigationPath>) {
        _navigationPath = navigationPath
    }
    
    private var sectionSelected: SidebarSection {
        SidebarSection.allCases.first { section in
            section.itemList.contains(itemSelected)
        } ?? .dashboard
    }
    
    var body: some View {
        NavigationSplitView {
            Sidebar(itemSelected: $itemSelected, userLogged: viewModel.userLogged)
        } detail: {
            VStack(spacing: .zero) {
                Breadcrumb(routeList: [sectionSelected.name, itemSelected.name, subNavigation])
                
                detailView
                    .isOS(.macOS) { view in
                        view.frame(
                            minWidth: Constants.screenMinWidth,
                            minHeight: Constants.screenMinHeight,
                            maxHeight: .infinity
                        )
                    }
            }
            .navigationTitle(sectionSelected.name)
            .toolbarBackground(.imsPrimary)
            .toolbar {
                if itemSelected == .profile {
                    ToolbarItem(placement: .destructiveAction) {
                        logoutButton
                    }
                }
            }
            .onAppear {
                viewModel.getUserLogged()
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder private var detailView: some View {
        switch itemSelected {
            case .users: UserListView()
            case .reports: ReportView(subNavigation: $subNavigation)
            case .salesHistory: SalesHistoryView()
            case .graphs: GraphView()
            case .invoiceSale: InvoiceSaleView()
            case .addProduct: AddProductView()
            case .productList: ProductListView()
            case .profile: ProfileView()
        }
    }
    
    private var logoutButton: some View {
        Button("Salir") {
            withAnimation {
                viewModel.logout()
            }
        }
        .buttonStyle(
            GradientButtonStyle(
                imageRight: "figure.walk.arrival",
                buttonHeight: OSType.current == .iOS ? Constants.iOSButtonHeight : Constants.macOSButtonHeight,
                gradientColors: [.redGradient, .orangeGradient]
            )
        )
        .onReceive(viewModel.$logoutSuccess) { isLogoutSuccess in
            if navigationPath.count > .zero, isLogoutSuccess {
                navigationPath.removeLast()
            }
        }
    }
}

#Preview {
    MainView(navigationPath: .constant(NavigationPath()))
}
