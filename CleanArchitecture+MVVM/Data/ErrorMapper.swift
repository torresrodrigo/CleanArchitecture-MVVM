//
//  ErrorMapper.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 09/07/2024.
//

import Foundation

class ErrorMapper {
    func map(error: HTTPClientError?) -> CountryDomainError {
        return .generic
    }
}
