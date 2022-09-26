//
//  LoginInteractor.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import UIKit

protocol LoginInteractorProtocol {
    func login(request: Login.Firebase.Request)
}

final class LoginInteractor: LoginInteractorProtocol {
    private let presenter: LoginPresenterProtocol
    private let worker: LoginWorker

    init(presenter: LoginPresenterProtocol, worker: LoginWorker) {
        self.presenter = presenter
        self.worker = worker
    }

    func login(request: Login.Firebase.Request) {
        worker.signInUser(email: request.email, password: request.password) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let user):
                let request = Login.Firebase.Response()
                self.presenter.presentHome(response: request)
            case .failure(let error):
                let request = Login.Error.Response(message: error.localizedDescription)
                self.presenter.presentError(response: request)
            }
        }
    }
}
