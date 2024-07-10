//
//  AllCountriesFactory.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 10/07/2024.
//

import Foundation
import UIKit

struct AllCountriesModuleFactory {
    
    static func buildUseCase() -> GetAllCountriesUseCaseType {
        let httpClient: HTTPClient = NetworkManager.shared
        let getAllCountriesRemoteDataSource: GetAllCountriesRemoteDataSourceType = GetAllCountriesAPI(httpClient: httpClient)
        let errorMapper: ErrorMapper = ErrorMapper()
        let repository: GetAllCountriesRepositoryType = CountryRepository(getAllCountriesRemoteDataSource: getAllCountriesRemoteDataSource, errorMapper: errorMapper)
        let useCase: GetAllCountriesUseCaseType = GetAllCountriesUseCase(repository: repository)
        return useCase
    }
    
    static func buildViewController() -> UIViewController {
        let useCase: GetAllCountriesUseCaseType = AllCountriesModuleFactory.buildUseCase()
        let viewModel: AllCountriesViewModel = AllCountriesViewModel(useCase: useCase)
        let viewController: UIViewController = AllCountriesViewController(viewModel: viewModel)
        return viewController
    }
}
