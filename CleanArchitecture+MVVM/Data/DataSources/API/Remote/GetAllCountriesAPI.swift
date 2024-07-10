//
//  GetAllCountriesAPI.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 09/07/2024.
//

import Foundation

struct GetAllCountriesAPI: GetAllCountriesRemoteDataSourceType {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func execute() async -> Result<[CountryDTO], HTTPClientError> {
        let request: HTTPRequest = GetAllCountriesAPIEndpoint()
        
        do {
            let result = try await httpClient.perform(request, decodeTo: [CountryDTO].self)
            return .success(result)
        } catch {
            return .failure(error as? HTTPClientError ?? HTTPClientError.notFound)
        }
    }
    
}
