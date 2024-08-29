//
//  FileFactory.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/7/24.
//

import Foundation

final class FileFactory {
    static func makeUserStringFormatted(users: [UserModel]) -> String {
        let header: String = "Nombre, Email, Roles, Fecha"
        
        let mappedUsers: String = users.map { user in
            let userName = "\(user.firstName) \(user.lastName)".capitalized
            let roles = user.roles?.map { $0.name }.joined(separator: "-")
            let updatedAt = user.updatedAt.dayMonthYear
            
            return "\(userName), \(user.email), \(roles ?? ""), \(updatedAt)"
        }.joined(separator: "\n")
        
        let stringFormatted: String = [header, mappedUsers].joined(separator: "\n")
        return stringFormatted
    }
    
    static func makeHistoryStringFormatted(histories: [InvoiceModel]) -> String {
        let header: String = "Nombre, Identificacion, Fecha, Pago Total"
        
        let mappedUsers: String = histories.map { history in
            "\(history.customerName), \(history.customerIdentification), \(history.createdAt.dayMonthYear), $\(history.totalAmount)"
        }.joined(separator: "\n")
        
        let stringFormatted: String = [header, mappedUsers].joined(separator: "\n")
        return stringFormatted
    }
}
