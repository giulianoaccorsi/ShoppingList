//
//  CellphoneFactory.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

enum CellphoneFactory {
    static func make(cpfModel: CPFModel) -> CellphoneViewController {
        let presenter = CellphonePresenter()
        let interactor = CellphoneInteractor(presenter: presenter, cpfModel: cpfModel)
        let viewController = CellphoneViewController(interactor: interactor)

        presenter.viewController = viewController

        return viewController
    }
}
