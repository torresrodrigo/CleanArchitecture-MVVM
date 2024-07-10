//
//  NetworkError.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 03/07/2024.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case requestFailed(Error)
    case invalidResponse
    case dataNotFound
    case decodingFailed(Error)
    case encodingFailed(Error)
    case notFound
    case internalServerError
    case unknownError(statusCode: Int)
}

struct DecodingError: Error {
    let message: String
}
