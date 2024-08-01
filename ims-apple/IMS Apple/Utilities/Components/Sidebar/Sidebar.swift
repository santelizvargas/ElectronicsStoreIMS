//
//  Sidebar.swift
//  IMS Apple
//
//  Created by Macbook Air M1 on 31/7/24.
//

import SwiftUI

// MARK: - View Constants

private enum Constants {
    static let sectionTitlePadding: CGFloat = 5
    static let dividerPadding: CGFloat = -15
    static let imageSize: CGFloat = 20
    
    enum AppIcon {
        static let width: CGFloat = 200
        static let height: CGFloat = 75
    }
}

// MARK: - Sidebar View

struct Sidebar: View {
    @Binding private var itemSelected: SidebarItem
    
    init(itemSelected: Binding<SidebarItem>) {
        _itemSelected = itemSelected
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            appIconView
            
            CustomDivider()
                .padding(.horizontal, Constants.dividerPadding)
                .padding(.bottom)
            
            sectionListView
            
            Spacer()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .leading
        )
        .padding()
        .background(.imsPrimary)
    }
    
    // MARK: - App Icon View
    
    private var appIconView: some View {
        Image(.imsLogoWhite)
            .resizable()
            .frame(
                width: Constants.AppIcon.width,
                height: Constants.AppIcon.height
            )
    }
    
    // MARK: - Section List View
    
    private var sectionListView: some View {
        ForEach(SidebarSection.allCases, id: \.self) { section in
            VStack(alignment: .leading, spacing: .zero) {
                if section != .dashboard {
                    CustomDivider()
                        .padding(.bottom)
                }
                
                Text(section.name)
                    .font(.caption)
                    .foregroundStyle(.imsGray)
                    .padding(.bottom, Constants.sectionTitlePadding)
                
                itemListView(items: section.itemList)
            }
        }
    }
    
    // MARK: - Item List View
    
    private func itemListView(items: [SidebarItem]) -> some View {
        ForEach(items, id: \.self) { item in
            Button(item.name) {
                withAnimation(.snappy) {
                    itemSelected = item
                }
            }
            .buttonStyle(
                SidebarButtonStyle(
                    iconName: item.iconName,
                    isSelected: itemSelected == item
                )
            )
        }
    }
}

