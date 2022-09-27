//
//  LoggedInteractor.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 26/09/22.
//

import UIKit

protocol LoggedInteractorProtocol {
    func doSomething(request: Logged.Something.Request)
}

final class LoggedInteractor: LoggedInteractorProtocol {
    private let presenter: LoggedPresenterProtocol
    private let worker: LoggedWorker

    init(presenter: LoggedPresenterProtocol, worker: LoggedWorker) {
        self.presenter = presenter
        self.worker = worker
    }

    func doSomething(request: Logged.Something.Request) {
        let response = Logged.Something.Response()
        presenter.presentSomething(response: response)
    }
}
