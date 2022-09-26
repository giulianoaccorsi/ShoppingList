//
//  CPFInteractor.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

protocol CPFInteractorProtocol {
    func getInformation(request: CPF.NextStage.Request)
}

final class CPFInteractor: CPFInteractorProtocol {
    private let presenter: CPFPresenterProtocol
    private let email: String

    init(presenter: CPFPresenterProtocol, email: String) {
        self.presenter = presenter
        self.email = email
    }

    func getInformation(request: CPF.NextStage.Request) {
        let cpfModel = CPFModel(email: email, date: request.userInformation.date, cpf: request.userInformation.cpf)
        let response = CPF.NextStage.Response(cpfModel: cpfModel)
        presenter.presentNextStage(response: response)
    }
}
