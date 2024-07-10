//
//  CountryDTO.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 03/07/2024.
//

import Foundation

struct CountryDTO: Codable {
    let name: NameDTO
    let population: Int
    let flag: String
    let region: String
}
