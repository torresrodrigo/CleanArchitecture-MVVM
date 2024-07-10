//
//  HTTPClientError.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 09/07/2024.
//

import Foundation

enum HTTPClientError: Error {
    case badUrl
    case requestFailed(Error)
    case invalidResponse
    case dataNotFound
    case decodingFailed(Error)
    case encodingFailed(Error)
    case notFound
    case internalServerError
    case unknownError(statusCode: Int)
}
