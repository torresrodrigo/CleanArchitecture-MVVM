//
//  ViewController.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 03/07/2024.
//

import UIKit

class AllCountriesViewController: UIViewController {
    
    let viewModel: AllCountriesViewModel
    
    init(viewModel: AllCountriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        getDataUseCase()
    }
    
    
    private func getDataUseCase() {
        Task {
            do {
                let resultCountries = await viewModel.getAllCountries()
                print(resultCountries)
            } catch {
                print(error)
            }
        
        }
    }

}

