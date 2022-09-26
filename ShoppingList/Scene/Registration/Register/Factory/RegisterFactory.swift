//
//  RegisterFactory.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import UIKit

enum RegisterFactory {
    static func make() -> RegisterViewController {
        let presenter = RegisterPresenter()
        let interactor = RegisterInteractor(presenter: presenter)
        let viewController = RegisterViewController(interactor: interactor)
        presenter.viewController = viewController

        return viewController
    }
}
