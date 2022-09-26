//
//  RegisterScenarios.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import UIKit

// swiftlint:disable nesting
enum RegisterScenarios {
    enum NextStage {
        struct Request {
            let email: String
        }
        struct Response {
            let email: String
        }
        struct ViewModel {
            let email: String
        }
    }
    enum Dismiss {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
}
