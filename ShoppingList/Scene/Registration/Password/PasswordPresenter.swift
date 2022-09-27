//
//  PasswordPresenter.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import UIKit

protocol PasswordPresenterProtocol {
    func presentRegisterUser(response: Password.FinishRegister.Response)
}

final class PasswordPresenter: PasswordPresenterProtocol {
    weak var viewController: PasswordViewControllerProtocol?

    func presentRegisterUser(response: Password.FinishRegister.Response) {
        switch response {
        case .sucess(user: _):
            let viewModel = Password.FinishRegister.ViewModel.sucess
            viewController?.displayRegisterUser(viewModel: viewModel)
        case .failure(error: let error):
            let viewModel = Password.FinishRegister.ViewModel.failure(error: error.localizedDescription)
            viewController?.displayRegisterUser(viewModel: viewModel)
        }
    }
}
