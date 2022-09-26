//
//  CEPScenarios.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

// swiftlint: disable nesting
enum CEP {
    enum NextSage {
        struct Request {
            let cep: String
        }
        struct Response {
            let cepModel: CEPModel
        }
        struct ViewModel {
            let cepModel: CEPModel
        }
    }
}
