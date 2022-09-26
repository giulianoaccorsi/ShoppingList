//
//  AddressPresenter.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

protocol AddressPresenterProtocol {
    func showLoading()
    func hideLoading()
    func onError(message: String)
    func presentAddress(response: Address.GetAddress.Response)
    func presentNextStage(response: Address.NextStage.Response)
}

final class AddressPresenter: AddressPresenterProtocol {
    weak var viewController: AddressViewControllerProtocol?

    func showLoading() {
        self.viewController?.showLoading()
    }

    func hideLoading() {
        self.viewController?.hideLoading()
    }

    func onError(message: String) {

    }

    func presentNextStage(response: Address.NextStage.Response) {
        let viewModel = Address.NextStage.ViewModel(address: response.address)
        viewController?.displayNextStage(viewModel: viewModel)
    }

    func presentAddress(response: Address.GetAddress.Response) {
        let viewModel = Address.GetAddress.ViewModel(address: response.address)
        viewController?.displayAddress(viewModel: viewModel)
    }
}
