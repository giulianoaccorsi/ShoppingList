//
//  LoginScenarios.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import UIKit
import Firebase

// swiftlint: disable nesting
enum Login {
    enum Firebase {
        struct Request {
            let email: String
            let password: String
        }
        enum Response {
            case success(user: User)
            case failure(error: FirebaseAuthError)
        }
        enum ViewModel {
            case success
            case failure(error: String)
        }
    }
}
