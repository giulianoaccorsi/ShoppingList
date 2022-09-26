//
//  CellphoneInteractor.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

protocol CellphoneInteractorProtocol {
    func nextStage(request: Cellphone.NextStage.Request)
}

final class CellphoneInteractor: CellphoneInteractorProtocol {
    private let presenter: CellphonePresenterProtocol
    private let cpfModel: CPFModel

    init(presenter: CellphonePresenterProtocol, cpfModel: CPFModel) {
        self.presenter = presenter
        self.cpfModel = cpfModel
    }

    func nextStage(request: Cellphone.NextStage.Request) {
        let model = CellphoneModel(email: cpfModel.email,
                                   cpf: cpfModel.cpf,
                                   date: cpfModel.date,
                                   cellphone: request.cellphoneNumber)
        let response = Cellphone.NextStage.Response(cellphoneModel: model)
        presenter.presentNextStage(response: response)
    }
}
