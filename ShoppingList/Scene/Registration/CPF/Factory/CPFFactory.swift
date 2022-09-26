//
//  CPFFactory.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

enum CPFFactory {
    static func make(email: String) -> CPFViewController {
        let presenter = CPFPresenter()
        let interactor = CPFInteractor(presenter: presenter, email: email)
        let viewController = CPFViewController(interactor: interactor)
        presenter.viewController = viewController

        return viewController
    }
}
