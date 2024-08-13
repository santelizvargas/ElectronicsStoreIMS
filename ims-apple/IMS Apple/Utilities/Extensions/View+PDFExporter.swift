//
//  View+PDFExporter.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/13/24.
//

import SwiftUI

extension View {
    
    /// Make a PDF file from View content
    func exportView(with fileName: String) -> some View {
        PDFExporterContainer(
            fileName: fileName) {
                self
            }
    }
}
