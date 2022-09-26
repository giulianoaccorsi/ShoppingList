//
//  PasswordInteractor.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import UIKit

protocol PasswordInteractorProtocol {
    func registerUser(request: Password.FinishRegister.Request)
}

final class PasswordInteractor: PasswordInteractorProtocol {
    private let presenter: PasswordPresenterProtocol
    private let worker: PasswordWorker
    private let model: AddressModel

    init(presenter: PasswordPresenterProtocol, worker: PasswordWorker, model: AddressModel) {
        self.presenter = presenter
        self.worker = worker
        self.model = model
    }

    func registerUser(request: Password.FinishRegister.Request) {
        worker.createUser(email: model.email, password: request.password, model: model) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                let response = Password.FinishRegister.Response()
                self.presenter.presentSuccess(response: response)
            case .failure(let error):
                let response = Password.FailedError.Response(error: error)
                self.presenter.presentError(response: response)
            }
        }
    }
}
