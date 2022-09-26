//
//  PasswordWorker.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

final class PasswordWorker {
    let service: FirebaseNetworkProtocol

    init(service: FirebaseNetworkProtocol) {
        self.service = service
    }

    func createUser(email: String,
                    password: String,
                    model: AddressModel,
                    onComplete: @escaping (Result<User, FirebaseAuthError>) -> Void) {
        service.createUser(email: email, password: password, model: model, onComplete: onComplete)
    }
}
