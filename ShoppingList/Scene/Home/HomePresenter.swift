//
//  HomePresenter.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import UIKit

protocol HomePresenterProtocol {
    func presentRegister(response: HomeScenarios.Register.Response)
    func presentLogin(response: HomeScenarios.Login.Response)
}

final class HomePresenter: HomePresenterProtocol {
    weak var viewController: HomeViewControllerProtocol?

    func presentRegister(response: HomeScenarios.Register.Response) {
        let viewModel = HomeScenarios.Register.ViewModel()
        viewController?.displayRegister(viewModel: viewModel)
    }

    func presentLogin(response: HomeScenarios.Login.Response) {
        let viewModel = HomeScenarios.Login.ViewModel()
        viewController?.displayLogin(viewModel: viewModel)
    }
}
