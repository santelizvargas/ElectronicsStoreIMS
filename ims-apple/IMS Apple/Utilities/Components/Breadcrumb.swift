//
//  Breadcrumb.swift
//  IMS Apple
//
//  Created by Macbook Air M1 on 31/7/24.
//

import SwiftUI

struct Breadcrumb: View {
    private let maxHeight: CGFloat = 50
    private let routeList: [String]
    
    init(routeList: [String]) {
        self.routeList = routeList
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(.imsPrimary)
                .overlay(alignment: .top) {
                    CustomDivider()
                }
            
            Text(routeList.joined(separator: " / "))
                .foregroundStyle(.imsWhite)
                .padding(.horizontal)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: maxHeight,
            alignment: .leading
        )
    }
}
