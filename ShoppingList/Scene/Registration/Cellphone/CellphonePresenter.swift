//
//  CellphonePresenter.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

protocol CellphonePresenterProtocol {
    func presentNextStage(response: Cellphone.NextStage.Response)
}

final class CellphonePresenter: CellphonePresenterProtocol {
    weak var viewController: CellphoneViewControllerProtocol?

    func presentNextStage(response: Cellphone.NextStage.Response) {
        let viewModel = Cellphone.NextStage.ViewModel(cellphoneModel: response.cellphoneModel)
        viewController?.displayNextStage(viewModel: viewModel)
    }
}
