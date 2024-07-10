//
//  GetAllCountriesRepositoryType.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 03/07/2024.
//

import Foundation

public protocol GetAllCountriesRepositoryType {
    func execute() async -> Result<[Country], CountryDomainError>
}
