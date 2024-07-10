//
//  HTTPClient.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 09/07/2024.
//

import Foundation

protocol HTTPClient {
    func perform<T: Decodable>(_ request: HTTPRequest, decodeTo type: T.Type) async throws -> T
}
