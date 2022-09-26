//
//  CEPNetwork.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import Foundation

final class CEPNetwork {
    private let getRequest: GetRequestable

    init(getRequest: GetRequestable) {
        self.getRequest = getRequest
    }
}

extension CEPNetwork: CEPProtocol {
    func loadCep(cep: String, onComplete: @escaping (Result<Cep, ServiceError>) -> Void) {
        getRequest.get(urlString: "https://viacep.com.br/ws/\(cep)/json/", parser: Cep.self) { result in
            switch result {
            case .success(let cepObject):
                onComplete(.success(cepObject))
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}
