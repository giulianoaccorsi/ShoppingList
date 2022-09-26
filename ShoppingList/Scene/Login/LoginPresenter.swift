//
//  LoginPresenter.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import UIKit

protocol LoginPresenterProtocol {
    func presentHome(response: Login.Firebase.Response)
    func presentError(response: Login.Error.Response)
}

final class LoginPresenter: LoginPresenterProtocol {
    weak var viewController: LoginViewControllerProtocol?

    func presentHome(response: Login.Firebase.Response) {
        let viewModel = Login.Firebase.ViewModel()
        viewController?.displayHome(viewModel: viewModel)
    }

    func presentError(response: Login.Error.Response) {
        let viewModel = Login.Error.ViewModel(message: response.message)
        viewController?.displayError(viewModel: viewModel)
    }
}
