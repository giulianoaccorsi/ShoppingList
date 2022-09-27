//
//  PasswordScenarios.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import UIKit
import FirebaseAuth

// swiftlint: disable nesting
enum Password {
    enum FinishRegister {
        struct Request {
            let password: String
        }
        enum Response {
            case sucess(user: User)
            case failure(error: FirebaseAuthError)
        }
        enum ViewModel {
            case sucess
            case failure(error: String)
        }
    }
}
