//
//  CEPFactory.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

enum CEPFactory {
    static func make(cellphone: CellphoneModel) -> CEPViewController {
        let presenter = CEPPresenter()
        let interactor = CEPInteractor(presenter: presenter, cellphoneModel: cellphone)
        let viewController = CEPViewController(interactor: interactor)
        presenter.viewController = viewController

        return viewController
    }
}
