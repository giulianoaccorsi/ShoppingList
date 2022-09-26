//
//  HomeFactory.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import Foundation

enum HomeFactory {
    static func make() -> HomeViewController {
        let presenter = HomePresenter()
        let interactor = HomeInteractor(presenter: presenter)
        let viewController = HomeViewController(interactor: interactor)
        presenter.viewController = viewController

        return viewController
    }
}
