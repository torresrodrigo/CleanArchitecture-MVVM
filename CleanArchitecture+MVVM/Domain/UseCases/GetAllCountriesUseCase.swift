//
//  GetAllCountriesUseCase.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 03/07/2024.
//

import Foundation

public protocol GetAllCountriesUseCaseType {
    func execute() async -> Result<[Country], CountryDomainError>
}

struct GetAllCountriesUseCase: GetAllCountriesUseCaseType {
    
    private let repository: GetAllCountriesRepositoryType
    
    init(repository: GetAllCountriesRepositoryType) {
        self.repository = repository
    }
    
    func execute() async -> Result<[Country], CountryDomainError> {
        let result = await repository.execute()
        
        guard let allCountries = try? result.get() else {
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            
            return .failure(error)
            
        }
        
        return .success(allCountries)
    }
    
}
