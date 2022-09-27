//
//  LoggedPresenter.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 26/09/22.
//

import UIKit

protocol LoggedPresenterProtocol {
    func presentSomething(response: Logged.Something.Response)
}

final class LoggedPresenter: LoggedPresenterProtocol {
    weak var viewController: LoggedViewControllerProtocol?

    func presentSomething(response: Logged.Something.Response) {
        let viewModel = Logged.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
