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
    static let jsonContentType: String = "application/json"
    static let multipartContentType: String = "multipart/form-data; boundary="
    static let lineBreak: String = "\r\n"
}

final class NetworkManager {
    
    private var boundary: String { "\(UUID().uuidString)" }
    
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
    
    func uploadImage(path: IMSPath,
                     with parameters: [String: Any],
                     imageData: Data) async throws -> Data {
        
        components.path = path.endPoint
        guard let url = components.url else { throw IMSError.badUrl }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post.rawValue
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body: Data = Data()
        
        for (key, value) in parameters {
            body.appendString("--\(boundary)\(Constants.lineBreak)")
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\(Constants.lineBreak)")
            body.appendString("\(value)\(Constants.lineBreak)")
        }
        
        let uuid: String = UUID().uuidString
        body.appendString("--\(boundary)\(Constants.lineBreak)")
        body.appendString("Content-Disposition: form-data; name=\"images\"; filename=\"\(uuid).jpg\"\(Constants.lineBreak)")
        body.appendString("Content-Type: image/jpeg\(Constants.lineBreak)\(Constants.lineBreak)")
        body.append(imageData)
        body.appendString("\(Constants.lineBreak)")
        body.appendString("--\(boundary)\(Constants.lineBreak)--")
        
        request.httpBody = body
        
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
}
