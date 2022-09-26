//
//  CEPInteractor.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

protocol CEPInteractorProtocol {
    func getCEP(request: CEP.NextSage.Request)
}

final class CEPInteractor: CEPInteractorProtocol {
    private let presenter: CEPPresenterProtocol
    private let cellphoneModel: CellphoneModel

    init(presenter: CEPPresenterProtocol, cellphoneModel: CellphoneModel) {
        self.presenter = presenter
        self.cellphoneModel = cellphoneModel
    }

    func getCEP(request: CEP.NextSage.Request) {
        let model = CEPModel(email: cellphoneModel.email,
                             cpf: cellphoneModel.cpf,
                             date: cellphoneModel.date,
                             cellphone: cellphoneModel.cellphone,
                             cep: request.cep)
        let response = CEP.NextSage.Response(cepModel: model)
        presenter.presentNextStage(response: response)
    }
}
