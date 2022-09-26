//
//  LoginFactory.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import UIKit

enum LoginFactory {
    static func make() -> LoginViewController {
        let worker = LoginWorker(service: FirebaseNetwork())
        let presenter = LoginPresenter()
        let interactor = LoginInteractor(presenter: presenter, worker: worker)
        let viewController = LoginViewController(interactor: interactor)
        presenter.viewController = viewController

        return viewController
    }
}
