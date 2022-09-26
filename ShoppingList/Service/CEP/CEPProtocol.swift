//
//  teste.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import Foundation

protocol CEPProtocol {
    func loadCep(cep: String, onComplete: @escaping (Result<Cep, ServiceError>) -> Void)
}
