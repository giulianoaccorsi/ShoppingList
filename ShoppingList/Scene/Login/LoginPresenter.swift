//
//  LoginPresenter.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import UIKit

protocol LoginPresenterProtocol {
    func presentHome(response: Login.Firebase.Response)
}

final class LoginPresenter: LoginPresenterProtocol {
    weak var viewController: LoginViewControllerProtocol?

    func presentHome(response: Login.Firebase.Response) {
        switch response {
        case .success(user: _):
            let viewModel = Login.Firebase.ViewModel.success
            viewController?.displayHome(viewModel: viewModel)
        case .failure(error: let error):
            let viewModel = Login.Firebase.ViewModel.failure(error: error.localizedDescription)
            viewController?.displayHome(viewModel: viewModel)
        }
    }
}
