//
//  GetAllCountriesRemoteDataSource.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 09/07/2024.
//

import Foundation

protocol GetAllCountriesRemoteDataSourceType {
    func execute() async -> Result<[CountryDTO], HTTPClientError>
}
