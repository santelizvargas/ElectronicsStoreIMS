//
//  HttpMethod.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/12/24.
//

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

enum IMSPath {
    case users
    case login
    case updatePassword
    case getProducts
    case productCount
    case register
    
    private var apiVersion: String { "/api/v1/" }
    
    var endPoint: String {
        var path: String {
            switch self {
                case .getProducts: "products"
                case .productCount: "products/count"
                case .users: "auth"
                case .login: "auth/login"
                case .updatePassword: "auth/password"
                case .register: "/auth/register"
            }
        }
        return "\(apiVersion)\(path)/"
    }
}
