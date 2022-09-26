//
//  AddressScenarios.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import UIKit

// swiftlint: disable all
enum Address {
    enum GetAddress {
        struct Request {}
        struct Response {
            let address: AddressModel
        }
        struct ViewModel {
            let address: AddressModel
        }
    }

    enum NextStage {
        struct Request {
            let cep: Cep
        }
        struct Response {
            let address: AddressModel
        }
        struct ViewModel {
            let address: AddressModel
        }
    }
}
