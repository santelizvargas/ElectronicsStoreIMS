//
//  PermissionHandler.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/5/24.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

final class PermissionHandler {
    
    private func getDownloadsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
//    private func requestFileAccess() -> Bool {
//        let permissionStatus =
//    }
    
    private func showPanel() -> NSApplication.ModalResponse {
        let openPanel: NSOpenPanel = .init()
        openPanel.directoryURL = getDownloadsDirectory()
        openPanel.prompt = "Save"
        openPanel.showsTagField = true
        openPanel.nameFieldStringValue = "Name"
        openPanel.canChooseDirectories = true
        openPanel.canChooseFiles = false
        return openPanel.runModal()
    }
    
    func writeFile(data: String) -> Bool {
        
        if showPanel() == .OK {
            let fileName = getDownloadsDirectory().appendingPathComponent("IMSData.txt")
            do {
                try data.write(to: fileName, atomically: true, encoding: .utf8)
                return true
            } catch {
                print(error)
                return false
            }
        } else {
            return false
        }
    }
}
