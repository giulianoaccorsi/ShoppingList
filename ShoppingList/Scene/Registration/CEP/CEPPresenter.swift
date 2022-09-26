//
//  CEPPresenter.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

protocol CEPPresenterProtocol {
    func presentNextStage(response: CEP.NextSage.Response)
}

final class CEPPresenter: CEPPresenterProtocol {
    weak var viewController: CEPViewControllerProtocol?

    func presentNextStage(response: CEP.NextSage.Response) {
        let viewModel = CEP.NextSage.ViewModel(cepModel: response.cepModel)
        viewController?.displayNextStage(viewModel: viewModel)
    }
}
