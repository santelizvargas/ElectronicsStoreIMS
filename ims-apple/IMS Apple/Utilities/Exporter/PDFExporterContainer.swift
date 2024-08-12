//
//  PDFExporter.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/11/24.
//

import SwiftUI

struct PDFExporterContainer<Content: View>: View {
    private let fileName: String
    private let content: Content
    
    init(fileName: String, content: () -> Content) {
        self.fileName = fileName
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            content
                .contextMenu {
                    HStack {
                        #if os(iOS)
                        ShareLink("Exportar", item: render())
                        #else
                        Button("Exportar") {
                            NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: render().path)
                        }
                        #endif
                    }
                    .padding()
                }
        }
    }
    
    func render() -> URL {
        let rendered = ImageRenderer(content: content)
        
        let url: URL = .documentsDirectory.appendingPathComponent("\(fileName).pdf", conformingTo: .pdf)
        
        rendered.render { size, context in
            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil)
            else { return }
            
            pdf.beginPDFPage(nil)
            
            context(pdf)
            
            pdf.endPDFPage()
            pdf.closePDF()
        }
        
        return url
    }
}
