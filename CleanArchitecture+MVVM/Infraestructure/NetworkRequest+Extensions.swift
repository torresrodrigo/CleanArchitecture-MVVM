//
//  NetworkRequest+Extensions.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 03/07/2024.
//

import Foundation

extension NetworkRequest {
    func urlRequest() throws -> URLRequest {
        guard let url = url else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key.rawValue)
            }
        }
        
        if let parameters = parameters {
            if method == .get {
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                let parameterData = try JSONEncoder().encode(parameters)
                let parameterDictionary = try JSONSerialization.jsonObject(with: parameterData, options: []) as? [String: Any]
                urlComponents?.queryItems = parameterDictionary?.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                request.url = urlComponents?.url
            } else {
                do {
                    let jsonData = try JSONEncoder().encode(parameters)
                    request.httpBody = jsonData
                } catch {
                    throw NetworkError.encodingFailed(error)
                }
            }
        }
        
        return request
    }
}

