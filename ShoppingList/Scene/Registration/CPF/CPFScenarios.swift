//
//  CPFScenarios.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit
// swiftlint:disable nesting
enum CPF {
    enum NextStage {
        struct Request {
            let userInformation: (cpf: String, date: String)
        }
        struct Response {
            let cpfModel: CPFModel
        }
        struct ViewModel {
            let cpfModel: CPFModel
        }
    }
}
