//
//  AddressWorker.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

final class AddressWorker {
    let service: CEPProtocol

    init(service: CEPProtocol) {
        self.service = service
    }

    func loadCEP(cep: String, onComplete: @escaping (Result<Cep, ServiceError>) -> Void) {
        service.loadCep(cep: cep, onComplete: onComplete)
    }
}
