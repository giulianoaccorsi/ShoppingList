//
//  AddressFactory.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

enum AddressFactory {
    static func make(cepModel: CEPModel) -> AddressViewController {
        let worker = AddressWorker(service: CEPNetwork(getRequest: GetRequest()))
        let presenter = AddressPresenter()
        let interactor = AddressInteractor(presenter: presenter, worker: worker, cepModel: cepModel)
        let viewController = AddressViewController(interactor: interactor)
        presenter.viewController = viewController

        return viewController
    }
}
