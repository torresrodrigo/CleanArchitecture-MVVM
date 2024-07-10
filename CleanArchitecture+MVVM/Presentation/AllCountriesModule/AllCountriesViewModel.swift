//
//  AllCountriesViewModel.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 10/07/2024.
//

import Foundation

struct AllCountriesViewModel {
    
    let useCase: GetAllCountriesUseCaseType
    
    init(useCase: GetAllCountriesUseCaseType) {
        self.useCase = useCase
    }
    
    func getAllCountries() async -> [Country] {
        let resultCountries = await useCase.execute()
        
        guard let countries = try? resultCountries.get() else {
            return []
        }
        return countries
    }
    
}
