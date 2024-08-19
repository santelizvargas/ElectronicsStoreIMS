//
//  MainView.swift
//  IMS Apple
//
//  Created by Steven Santeliz on 17/7/24.
//

import SwiftUI

private enum Constants {
    static let screenMinWidth: CGFloat = 700
    static let screenMinHeight: CGFloat = 500
}

struct MainView: View {
    @State private var itemSelected: SidebarItem = .graphs
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
            Sidebar(itemSelected: $itemSelected)
        } detail: {
            VStack(spacing: .zero) {
                Breadcrumb(routeList: [sectionSelected.name, itemSelected.name])
                
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
                ToolbarItem(placement: .confirmationAction) {
                    if itemSelected != .productList {
                        profileButton
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    @ViewBuilder private var detailView: some View {
        switch itemSelected {
            case .users: UserListView()
            case .salesHistory: SalesHistoryView()
            case .graphs: GraphView()
            case .invoiceSale: InvoiceSaleView()
            case .addProduct: AddProductView()
            case .productList: ProductListView()
            case .profile: ProfileView()
        }
    }
    
    private var profileButton: some View {
        Button {
            withAnimation {
                itemSelected = .profile
            }
        } label: {
            ProfileImage(fullName: "Juan Perez")
        }
        .buttonStyle(.plain)
        .contextMenu {
            Button("Cerrar sesión") {
                viewModel.logout()
            }
        }
        .onChange(of: viewModel.logoutSuccess) { _, _ in
            if navigationPath.count > .zero {
                navigationPath.removeLast()
            }
        }
    }
}

#Preview {
    MainView(navigationPath: .constant(NavigationPath()))
}
