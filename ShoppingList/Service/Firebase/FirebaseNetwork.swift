//
//  FirebaseNetwork.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 25/09/22.
//

import Firebase
import Foundation

enum FirebaseAuthError: Error {
    case invalidEmail
    case emailAlreadyInUse
    case weakPassword
    case defaultError
    case wrongPassword
    case userNotFound

    var localizedDescription: String {
        switch self {
        case .invalidEmail:
            return "Você colocou um e-mail inválido"
        case .emailAlreadyInUse:
            return "Essa conta já existe"
        case .weakPassword:
            return "Esta senha é muito fraca"
        case .defaultError:
            return "Erro desconhecido :("
        case .wrongPassword:
            return "Você errou a senha !"
        case .userNotFound:
            return "Usuário não existe :("
        }
    }
}

protocol FirebaseNetworkProtocol {
    func createUser(email: String,
                    password: String,
                    model: AddressModel,
                    onComplete: @escaping (Result<User, FirebaseAuthError>) -> Void)
    func signIn(email: String,
                password: String,
                onComplete: @escaping (Result<User, FirebaseAuthError>) -> Void)
}

final class FirebaseNetwork {

    private let collection = "user"
    private lazy var auth = Auth.auth()
    private let fireStore: Firestore = Firestore.firestore()
    private var listener: ListenerRegistration!

    private func createUserInFireStore(user: AddressModel) {
        let data: [String: Any] = [
            "cep": user.cep,
            "celular": user.cellphone,
            "cpf": user.cpf,
            "email": user.email,
            "dataNascimento": user.date,
            "bairro": user.cepModel.bairro,
            "estado": user.cepModel.localidade,
            "rua": user.cepModel.logradouro,
            "uf": user.cepModel.uf
        ]

        fireStore.collection(collection).addDocument(data: data)
    }
}

extension FirebaseNetwork: FirebaseNetworkProtocol {
    func signIn(email: String,
                password: String,
                onComplete: @escaping (Result<User, FirebaseAuthError>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                let authError = AuthErrorCode.Code(rawValue: error._code)

                switch authError {
                case .invalidEmail:
                    onComplete(.failure(.invalidEmail))
                case .wrongPassword:
                    onComplete(.failure(.wrongPassword))
                case .userNotFound:
                    onComplete(.failure(.userNotFound))
                default:
                    onComplete(.failure(.defaultError))
                }
            } else {
                guard let user = result?.user else { return }
                onComplete(.success(user))
            }
        }
    }

    func createUser(email: String,
                    password: String,
                    model: AddressModel,
                    onComplete: @escaping (Result<User, FirebaseAuthError>) -> Void) {

        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self else { return }
            if let error = error {
                let authError = AuthErrorCode.Code(rawValue: error._code)

                switch authError {
                case .invalidEmail:
                    onComplete(.failure(.invalidEmail))
                case .emailAlreadyInUse:
                    onComplete(.failure(.emailAlreadyInUse))
                case .weakPassword:
                    onComplete(.failure(.weakPassword))
                default:
                    onComplete(.failure(.defaultError))
                }
            } else {
                guard let user = result?.user else { return }
                self.createUserInFireStore(user: model)
                onComplete(.success(user))
            }
        }
    }
}
