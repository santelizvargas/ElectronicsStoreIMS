//
//  BackupListView.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 6/9/24.
//

import SwiftUI

final class BackupListViewModel: ObservableObject {
    @Published var isFetchInProgress: Bool = false
    @Published var backupList: [String] = []
    private lazy var backupManager: DatabaseManager = DatabaseManager()
    
    init() {
        getBackupList()
    }
    
    func createBackup() {
        isFetchInProgress = true
        Task { @MainActor in
            do {
                try await backupManager.backup()
                getBackupList()
                isFetchInProgress = false
            } catch {
                isFetchInProgress = false
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func restore(name: String) {
        isFetchInProgress = true
        Task { @MainActor in
            do {
                try await backupManager.restore(backup: name)
                isFetchInProgress = false
            } catch {
                isFetchInProgress = false
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func getBackupList() {
        isFetchInProgress = true
        Task { @MainActor in
            do {
                backupList = try await backupManager.list()
                isFetchInProgress = false
            } catch {
                isFetchInProgress = false
                guard let error = error as? IMSError else { return }
                debugPrint(error.localizedDescription)
            }
        }
    }
}

struct BackupListView: View {
    @ObservedObject private var viewModel: BackupListViewModel = .init()
    
    var body: some View {
        VStack {
            HStack {
                Text("Respaldo de base de datos")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    viewModel.createBackup()
                } label: {
                    Text("Crear respaldo")
                }
                .buttonStyle(GradientButtonStyle(imageLeft: "externaldrive.badge.plus"))
            }
            
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.backupList, id: \.self) { item in
                    HStack {
                        Text(item)
                            .frame(maxWidth: .infinity)
                        
                        Text(getDate(item: item))
                            .frame(maxWidth: .infinity)
                            
                        Menu {
                            Button("Restaurar") {
                                viewModel.restore(name: item)
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                        .menuStyle(.borderlessButton)
                        .menuIndicator(.hidden)
                        .frame(width: 20)
                    }
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.imsGraySecundary, lineWidth: 2)
                    }
                }
            }
        }
        .padding()
        .frame(width: 700, height: 500)
        .overlay {
            if viewModel.isFetchInProgress {
                CustomProgressView()
            }
        }
    }
    
    private func getDate(item: String) -> String {
        item.replacingOccurrences(of: "database-backup-", with: "")
            .replacingOccurrences(of: ".sql", with: "")
            .yearMonthDayHoursMinutes
    }
}

#Preview {
    BackupListView()
}
