//
//  RegisterInteractor.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import UIKit

protocol RegisterInteractorProtocol {
    func dissmiss(request: RegisterScenarios.Dismiss.Request)
    func nextStage(request: RegisterScenarios.NextStage.Request)
}

final class RegisterInteractor: RegisterInteractorProtocol {

    private let presenter: RegisterPresenterProtocol
    init(presenter: RegisterPresenterProtocol) {
        self.presenter = presenter
    }

    func dissmiss(request: RegisterScenarios.Dismiss.Request) {
        let response = RegisterScenarios.Dismiss.Response()
        presenter.presentDismiss(response: response)
    }

    func nextStage(request: RegisterScenarios.NextStage.Request) {
        let response = RegisterScenarios.NextStage.Response(email: request.email)
        presenter.presentNextSage(response: response)
    }
}
