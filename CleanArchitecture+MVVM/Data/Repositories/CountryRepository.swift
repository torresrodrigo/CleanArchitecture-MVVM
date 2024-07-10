//
//  CountryRepository.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 09/07/2024.
//

import Foundation

class CountryRepository: GetAllCountriesRepositoryType {
    
    private let getAllCountriesRemoteDataSource: GetAllCountriesRemoteDataSourceType
    private let errorMapper: ErrorMapper
    
    init(getAllCountriesRemoteDataSource: GetAllCountriesRemoteDataSourceType, errorMapper: ErrorMapper) {
        self.getAllCountriesRemoteDataSource = getAllCountriesRemoteDataSource
        self.errorMapper = errorMapper
    }
    
    func execute() async -> Result<[Country], CountryDomainError> {
        let countriesResult = await getAllCountriesRemoteDataSource.execute()
        
        guard case .success(let countries) = countriesResult else {
            guard case .failure(let error) = countriesResult else {
                return .failure(.generic)
            }
            
            return .failure(errorMapper.map(error: error))
        }
        
        let countriesBuilderlist = countries.map { CountryBuilder(name: $0.name, population: $0.population, flag: $0.flag, region: $0.region) }
        
        return .success( countriesBuilderlist.compactMap { $0.build() } )
    }
    
}
