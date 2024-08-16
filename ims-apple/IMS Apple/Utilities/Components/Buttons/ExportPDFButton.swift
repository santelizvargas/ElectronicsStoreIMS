//
//  ExportPDFButton.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/13/24.
//

import SwiftUI

// MARK: - View + PDFExporter

struct ExportPDFButton<Content: View>: View {
    private let fileName: String
    private let content: Content
    
    init(fileName: String, content: () -> Content) {
        self.fileName = fileName
        self.content = content()
    }
    
    var body: some View {
        switch OSType.current {
            case .iOS:
                ShareLink(item: renderPDF) {
                    labelView
                }
            case .macOS:
                Button {
                    #if os(macOS)
                    NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: renderPDF.path)
                    #endif
                } label: {
                    labelView
                }
        }
    }
    
    // MARK: - Label View
    
    private var labelView: some View {
        HStack {
            Image(systemName: "square.and.arrow.up.fill")
            Text("Exportar")
        }
        .foregroundStyle(.white)
    }
    
    // MARK: - Current Directory
    
    private var currentDirectory: URL {
        switch OSType.current {
            case .macOS: .downloadsDirectory
            case .iOS: .documentsDirectory
        }
    }
    
    // MARK: - Current Date
    
    private var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH-mm"
        return dateFormatter.string(from: .now)
    }
    
    // MARK: - Render PDF
    
    @MainActor
    var renderPDF: URL {
        let url: URL = currentDirectory.appendingPathComponent("\(fileName) \(currentDate).pdf", conformingTo: .pdf)
        let rendered = ImageRenderer(content: content)
        
        rendered.render { size, context in
            var box = CGRect(origin: .zero, size: size)
            
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else { return }
            
            pdf.beginPDFPage(nil)
            
            context(pdf)
            
            pdf.endPDFPage()
            pdf.closePDF()
        }
        
        return url
    }
}
