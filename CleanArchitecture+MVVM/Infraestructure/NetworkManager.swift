//
//  NetworkManager.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 03/07/2024.
//

import Foundation
import UIKit

class NetworkManager: HTTPClient {
    static let shared = NetworkManager()
    private let urlSession = URLSession.shared
    
    private init() {}
    
    public func perform<T: Decodable>(_ request: HTTPRequest, decodeTo type: T.Type) async throws -> T {
        if #available(iOS 15.0, *) {
            let urlRequest = try request.urlRequest()
            let (data, response) = try await urlSession.data(for: urlRequest)
            try processResponse(response: response)
            return try decodeData(data: data, type: T.self)
        } else {
            return try await withCheckedThrowingContinuation { continuation in
                perform(request, decodeTo: type) { result in
                    switch result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    private func decodeData<T: Decodable>(data: Data, type: T.Type) throws -> T {
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            throw HTTPClientError.decodingFailed(error)
        }
    }
    
    private func processResponse(response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPClientError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return
        case 404:
            throw HTTPClientError.notFound
        case 500:
            throw HTTPClientError.internalServerError
        default:
            throw HTTPClientError.unknownError(statusCode: httpResponse.statusCode)
        }
    }
    
}

extension NetworkManager {
    private func perform<T: Decodable>(_ request: HTTPRequest, decodeTo type: T.Type, completion: @escaping (Result<T, HTTPClientError>) -> Void) {
        do {
            let urlRequest = try request.urlRequest()
            urlSession.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    completion(.failure(.requestFailed(error)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.dataNotFound))
                    return
                }
                
                do {
                    try self.processResponse(response: response)
                    let decodedObject = try self.decodeData(data: data, type: T.self)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(error as? HTTPClientError ?? .invalidResponse))
                }
            }.resume()
        } catch {
            completion(.failure(error as? HTTPClientError ?? .invalidResponse))
        }
    }
}

