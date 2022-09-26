//
//  PasswordPresenter.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import UIKit

protocol PasswordPresenterProtocol {
    func presentSuccess(response: Password.FinishRegister.Response)
    func presentError(response: Password.FailedError.Response)
}

final class PasswordPresenter: PasswordPresenterProtocol {
    weak var viewController: PasswordViewControllerProtocol?

    func presentSuccess(response: Password.FinishRegister.Response) {
        let viewModel = Password.FinishRegister.ViewModel()
        viewController?.displayRegisterUser(viewModel: viewModel)
    }

    func presentError(response: Password.FailedError.Response) {
        let viewModel = Password.FailedError.ViewModel(errorMessage: response.error.localizedDescription)
        viewController?.displayError(viewModel: viewModel)
    }
}
