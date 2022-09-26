//
//  AddressInteractor.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

protocol AddressInteractorProtocol {
    func loadCep(request: Address.GetAddress.Request)
    func nextStage(request: Address.NextStage.Request)
}

final class AddressInteractor: AddressInteractorProtocol {
    private let presenter: AddressPresenterProtocol
    private let worker: AddressWorker
    private let cepModel: CEPModel

    init(presenter: AddressPresenterProtocol, worker: AddressWorker, cepModel: CEPModel) {
        self.presenter = presenter
        self.cepModel = cepModel
        self.worker = worker
    }

    func nextStage(request: Address.NextStage.Request) {
        let addressModel = AddressModel(email: self.cepModel.email,
                                        cpf: self.cepModel.cpf,
                                        date: self.cepModel.date,
                                        cellphone: self.cepModel.cellphone,
                                        cep: self.cepModel.cep,
                                        cepModel: request.cep)
        let request = Address.NextStage.Response(address: addressModel)
        presenter.presentNextStage(response: request)
    }

    func loadCep(request: Address.GetAddress.Request) {
        presenter.showLoading()
        worker.loadCEP(cep: cepModel.cep) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let cep):
                self.presenter.hideLoading()
                let addressModel = AddressModel(email: self.cepModel.email,
                                                cpf: self.cepModel.cpf,
                                                date: self.cepModel.date,
                                                cellphone: self.cepModel.cellphone,
                                                cep: self.cepModel.cep,
                                                cepModel: cep)
                let response = Address.GetAddress.Response(address: addressModel)
                self.presenter.presentAddress(response: response)
            case .failure(let error):
                self.presenter.hideLoading()
                self.presenter.onError(message: error.localizedDescription)
            }
        }
    }
}
