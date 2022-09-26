//
//  LoginScenarios.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import UIKit

// swiftlint: disable nesting
enum Login {
    enum Firebase {
        struct Request {
            let email: String
            let password: String
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    enum Error {
        struct Request {
        }
        struct Response {
            let message: String
        }
        struct ViewModel {
            let message: String
        }
    }
}
