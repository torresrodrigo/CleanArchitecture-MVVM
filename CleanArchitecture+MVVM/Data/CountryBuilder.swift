//
//  CountryBuilder.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 09/07/2024.
//

import Foundation

class CountryBuilder {
    
    let name: NameDTO
    let population: Int
    let flag: String
    let region: String
    
    init(name: NameDTO, population: Int, flag: String, region: String) {
        self.name = name
        self.population = population
        self.flag = flag
        self.region = region
    }
    
    func build() -> Country {
        return Country(name: name.common, population: population, flag: flag, region: region)
    }
    
}
