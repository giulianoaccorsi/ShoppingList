//
//  LoggedFactory.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 26/09/22.
//

import UIKit

enum LoggedFactory {
    static func make() -> LoggedViewController {
        let worker = LoggedWorker()
        let presenter = LoggedPresenter()
        let interactor = LoggedInteractor(presenter: presenter, worker: worker)
        let viewController = LoggedViewController(interactor: interactor)
        presenter.viewController = viewController

        return viewController
    }
}
