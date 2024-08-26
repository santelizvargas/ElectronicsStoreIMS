//
//  Sidebar.swift
//  IMS Apple
//
//  Created by Macbook Air M1 on 31/7/24.
//

import SwiftUI
import SwiftData

// MARK: - View Constants

private enum Constants {
    static let sectionTitlePadding: CGFloat = 5
    static let dividerPadding: CGFloat = -15
    static let imageSize: CGFloat = 25
    
    enum AppIcon {
        static let width: CGFloat = 200
        static let height: CGFloat = 75
    }
}

// MARK: - Sidebar View

struct Sidebar: View {
    @Binding private var itemSelected: SidebarItem
    private let userLogged: UserModelPersistence?
    
    init(itemSelected: Binding<SidebarItem>,
         userLogged: UserModelPersistence?) {
        _itemSelected = itemSelected
        self.userLogged = userLogged
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
                if section != .user {
                    CustomDivider()
                        .padding(.bottom)
                }
                
                Text(section.name)
                    .font(.caption)
                    .foregroundStyle(.imsGraySecundary)
                    .padding(.bottom, Constants.sectionTitlePadding)
                
                if section == .user {
                    profileButton
                } else {
                    itemListView(items: section.itemList)
                }
            }
        }
        .isOS(.iOS) { $0.onKeyboardAppear() }
    }
    
    private var profileButton: some View {
        Button {
            withAnimation(.snappy) {
                itemSelected = .profile
            }
        } label: {
            HStack {
                ProfileImage(fullName: userShortName, size: Constants.imageSize)
                
                Text(userShortName)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .buttonStyle(
            SidebarButtonStyle(
                isSelected: itemSelected == .profile
            )
        )
        .contentShape(Rectangle())
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
            .contentShape(Rectangle())
        }
    }
    
    private var userShortName: String {
        guard let userLogged else { return "" }
        let firstName = userLogged.firstName.components(separatedBy: " ").first ?? ""
        let lastName = userLogged.lastName.components(separatedBy: " ").first ?? ""
        return "\(firstName) \(lastName)"
    }
}

