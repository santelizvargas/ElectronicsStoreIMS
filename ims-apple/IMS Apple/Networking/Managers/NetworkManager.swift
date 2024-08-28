//
//  NetworkManager.swift
//  IMS Apple
//
//  Created by Brandon Santeliz on 8/12/24.
//

import Foundation
import SwiftUI

private enum Constants {
    static let scheme: String = "https"
    static let baseURLString: String = "ims-electronics.up.railway.app"
}

final class NetworkManager {
    private var components: URLComponents = {
        var components: URLComponents = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURLString
        return components
    }()
    
    private func makeQueryItems(parameters: [String: Any]) -> [URLQueryItem] {
        parameters.map { key, value in
            URLQueryItem(name: key, value: value as? String)
        }
    }
    
    @discardableResult
    func makeRequest(path: IMSPath,
                     with parameters: [String: Any] = [:],
                     httpMethod: HttpMethod = .get) async throws -> Data {
        var components: URLComponents = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURLString
        components.path = path.endPoint
        components.queryItems = makeQueryItems(parameters: parameters)
        
        guard let url = components.url
        else { throw IMSError.badUrl }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if httpMethod != .get {
            let json = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = json
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  200...299 ~= statusCode
            else { throw IMSError.somethingWrong }
            
            return data
        } catch {
            throw IMSError.somethingWrong
        }
    }
    
    func makeMultipartRequest(path: IMSPath,
                              with parameters: [String: Any],
                              dataCollection: [Data]) async throws -> Data {
        let boundary: String = UUID().uuidString
        components.path = path.endPoint
        components.queryItems = makeQueryItems(parameters: parameters)
        guard let url = components.url else { throw IMSError.badUrl }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post.rawValue
        request.setValue("multipart/form-data; boundary=\(boundary)",
                         forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        for (key, value) in parameters {
            data.appendString("--\(boundary)\r\n")
            data.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            data.appendString("\(value)\r\n")
        }
        
        for (_, value) in dataCollection.enumerated() {
            data.appendString("--\(boundary)\r\n")
            data.appendString("Content-Disposition: form-data; name=\"images\"; filename=\"image-\(boundary).jpg\"\r\n")
            data.appendString("Content-Type: image/jpeg\r\n\r\n")
            data.append(value)
            data.appendString("\r\n")
        }
        
        data.appendString("--\(boundary)--\r\n")
        
        request.httpBody = data
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  200...299 ~= statusCode
            else { throw IMSError.somethingWrong }
            return data
        } catch {
            throw IMSError.somethingWrong
        }
    }
    
    // MARK: - Convert To Dictionaty
    
    func convertToDictionaty<T: Codable>(data: T) async throws -> [String: Any] {
        do {
            let jsonData = try JSONEncoder().encode(data)
            let parameters = try JSONSerialization.jsonObject(with: jsonData,
                                                              options: .mutableContainers) as? [String: Any]
            guard let parameters else { throw IMSError.somethingWrong }
            return parameters
        } catch {
            throw IMSError.somethingWrong
        }
    }
}
