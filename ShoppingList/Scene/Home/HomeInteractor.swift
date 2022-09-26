//
//  HomeViewInteractor.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import Foundation

protocol HomeInteractorProtocol {
    func tappedRegister(request: HomeScenarios.Register.Request)
    func tappedLogin(request: HomeScenarios.Login.Request)
}

final class HomeInteractor: HomeInteractorProtocol {
    private var presenter: HomePresenterProtocol

    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
    }

    func tappedRegister(request: HomeScenarios.Register.Request) {
        let response = HomeScenarios.Register.Response()
        self.presenter.presentRegister(response: response)
    }

    func tappedLogin(request: HomeScenarios.Login.Request) {
        let response = HomeScenarios.Login.Response()
        self.presenter.presentLogin(response: response)
    }
}
