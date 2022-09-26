//
//  RegisterPresenter.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import UIKit

protocol RegisterPresenterProtocol {
    func presentDismiss(response: RegisterScenarios.Dismiss.Response)
    func presentNextSage(response: RegisterScenarios.NextStage.Response)
}

final class RegisterPresenter: RegisterPresenterProtocol {
    weak var viewController: RegisterViewControllerProtocol?

    func presentDismiss(response: RegisterScenarios.Dismiss.Response) {
        let viewModel = RegisterScenarios.Dismiss.ViewModel()
        viewController?.tappedDismiss(viewModel: viewModel)
    }

    func presentNextSage(response: RegisterScenarios.NextStage.Response) {
        let viewModel = RegisterScenarios.NextStage.ViewModel(email: response.email)
        viewController?.tappedNextStage(viewModel: viewModel)
    }
}
