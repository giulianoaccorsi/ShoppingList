//
//  cep.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import Foundation

// swiftlint: disable all
struct Cep: Codable {
    let logradouro, bairro, localidade, uf: String
}
