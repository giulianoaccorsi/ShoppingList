//
//  CPFPresenter.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

protocol CPFPresenterProtocol {
    func presentNextStage(response: CPF.NextStage.Response)
}

final class CPFPresenter: CPFPresenterProtocol {
    weak var viewController: CPFViewControllerProtocol?

    func presentNextStage(response: CPF.NextStage.Response) {
        let viewModel = CPF.NextStage.ViewModel(cpfModel: response.cpfModel)
        viewController?.tappedButton(viewModel: viewModel)
    }
}
