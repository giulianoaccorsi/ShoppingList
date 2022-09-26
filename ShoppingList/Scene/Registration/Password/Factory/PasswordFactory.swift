//
//  PasswordFactory.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import UIKit

enum PasswordFactory {
    static func make(addressModel: AddressModel) -> PasswordViewController {
        let worker = PasswordWorker(service: FirebaseNetwork())
        let presenter = PasswordPresenter()
        let interactor = PasswordInteractor(presenter: presenter, worker: worker, model: addressModel)
        let viewController = PasswordViewController(interactor: interactor)
        presenter.viewController = viewController

        return viewController
    }
}
