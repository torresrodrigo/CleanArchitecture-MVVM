//
//  GetAllCountriesAPIEndpoint.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 09/07/2024.
//

import Foundation

struct GetAllCountriesAPIEndpoint: HTTPRequest {
    var url: URL? = URL(string: "https://restcountries.com/v3.1/all")
    
    var method: HTTPMethod = .get
    
    var headers: [HTTPHeader : String]?
    
    var parameters: Encodable?
    
}
