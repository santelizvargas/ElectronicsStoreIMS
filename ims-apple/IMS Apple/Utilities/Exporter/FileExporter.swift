//
//  PermissionHandler.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/5/24.
//

#if os(macOS)
import Foundation
import AppKit
import UniformTypeIdentifiers

final class FileExporter {
    
    private lazy var fileFactory: FileFactory = FileFactory()
    
    private lazy var downloadsDirectoryUrl: URL = {
        FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0]
    }()
    
    // MARK: - Functions
    
    private func savePanel(type: UTType, fileName: String) -> NSSavePanel {
        let panel: NSSavePanel = NSSavePanel()
        panel.directoryURL = downloadsDirectoryUrl
        panel.allowedContentTypes = [type]
        panel.nameFieldStringValue = fileName
        return panel
    }
    
    @discardableResult
    func exportUserList(from users: [UserModel]) -> Bool {
        let savePanel: NSSavePanel = savePanel(type: .commaSeparatedText, fileName: "IMS Users")
        
        if savePanel.runModal() == .OK,
           let url = savePanel.url {
            
            let stringFormatted: String = fileFactory.makeUserStringFormatted(users: users)
            
            do {
                try stringFormatted.write(to: url, atomically: true, encoding: .utf8)
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
    }
    
    // TODO: Export PDF File
}
#endif
