//
//  PasswordScenarios.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import UIKit

// swiftlint: disable nesting
enum Password {
    enum FinishRegister {
        struct Request {
            let password: String
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    enum FailedError {
        struct Request {}
        struct Response {
            let error: FirebaseAuthError
        }
        struct ViewModel {
            let errorMessage: String
        }
    }
}
