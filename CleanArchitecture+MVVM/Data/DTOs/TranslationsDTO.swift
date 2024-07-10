//
//  TranslationsDTO.swift
//  CleanArchitecture+MVVM
//
//  Created by Rodrigo on 03/07/2024.
//

import Foundation

struct TranslationsDTO: Codable {
    let translations: [String: LanguageTranslationDTO]
}
