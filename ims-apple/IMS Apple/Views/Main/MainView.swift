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
                    .frame(
                        minWidth: Constants.screenMinWidth,
                        minHeight: Constants.screenMinHeight,
                        maxHeight: .infinity
                    )
            }
            .navigationTitle(sectionSelected.name)
            .toolbarBackground(.imsPrimary)
        }
    }
    
    @ViewBuilder private var detailView: some View {
        switch itemSelected {
        case .users: UserListView()
        case .salesHistory: SalesHistoryView()
        default: Text(itemSelected.name)
        }
    }
}

#Preview {
    MainView()
}
