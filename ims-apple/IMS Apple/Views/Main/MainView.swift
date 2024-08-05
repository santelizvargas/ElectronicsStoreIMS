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
    @State private var itemSelected: SidebarItem = .users
    
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
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    profileButton
                }
            }
        }
    }
    
    @ViewBuilder private var detailView: some View {
        switch itemSelected {
        case .users: UserListView()
        default: Text(itemSelected.name)
        }
    }
    
    private var profileButton: some View {
        Button {
            
        } label: {
           ProfileImage(url: "https://pplam.png")
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MainView()
}
