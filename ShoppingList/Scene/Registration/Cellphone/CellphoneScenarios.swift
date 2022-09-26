//
//  CellphoneScenarios.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

// swiftlint: disable nesting
enum Cellphone {
    enum NextStage {
        struct Request {
            let cellphoneNumber: String
        }
        struct Response {
            let cellphoneModel: CellphoneModel
        }
        struct ViewModel {
            let cellphoneModel: CellphoneModel
        }
    }
}
