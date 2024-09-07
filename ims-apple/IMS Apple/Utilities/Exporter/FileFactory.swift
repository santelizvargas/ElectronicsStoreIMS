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
        
        let mappedHistory: String = histories.map { history in
            "\(history.customerName), \(history.customerIdentification), \(history.createdAt.dayMonthYear), $\(history.totalAmount)"
        }.joined(separator: "\n")
        
        let stringFormatted: String = [header, mappedHistory].joined(separator: "\n")
        return stringFormatted
    }
    
    static func makeProductStringFormatted(products: [ProductModel]) -> String {
        let header: String = "Nombre, Cantidad, Category, Precio, Descripcion"
        
        let mappedProducts: String = products.map { product in
            let description = product.description.replacingOccurrences(of: ",", with: "")
            let name = product.name.replacingOccurrences(of: ",", with: "")
            let stock = product.stock > .zero ? product.stock.description : "Agotado"
            
            return "\(name), \(stock), \(product.category.rawValue), $\(product.salePrice), \(description)"
        }.joined(separator: "\n")
        
        let stringFormatted: String = [header, mappedProducts].joined(separator: "\n")
        return stringFormatted
    }
}
