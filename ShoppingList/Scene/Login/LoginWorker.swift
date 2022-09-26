//
//  LoginWorker.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

final class LoginWorker {
    let service: FirebaseNetworkProtocol

    init(service: FirebaseNetworkProtocol) {
        self.service = service
    }

    func signInUser(email: String,
                    password: String,
                    onComplete: @escaping (Result<User, FirebaseAuthError>) -> Void) {
        service.signIn(email: email, password: password, onComplete: onComplete)
    }
}
