//
//  DetailViewContainer.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 6/9/24.
//

import SwiftUI

struct DetailViewContainer<Content: View, IMSCollection: Collection>: View {
    @Binding private var showDetailView: Bool
    private let content: Content
    private let collection: IMSCollection
    
    init(showDetailView: Binding<Bool>,
         collection: IMSCollection,
         @ViewBuilder content: () -> Content) {
        _showDetailView = showDetailView
        self.collection = collection
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    showDetailView = false
                } label: {
                    Label("Regresar", systemImage: "chevron.backward")
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                ExporterButton(
                    title: "Exportar",
                    fileName: "IMS Excel Exportacion",
                    collection: collection
                )
            }
            
            content.frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .leading
            )
        }
    }
}
