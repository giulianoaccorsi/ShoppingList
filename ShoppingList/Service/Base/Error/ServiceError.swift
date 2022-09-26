//
//  Error.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import Foundation

enum ServiceError: Error {
    case badURL
    case taskError
    case noResponse
    case invalidStatusCode(Int)
    case noData
    case decodingError

    var localizedDescription: String {
        switch self {
        case .badURL:
            return "URL Inválida :("
        case .taskError:
            return "Erro na Requisição"
        case .noResponse:
            return "Servidor não respondeu"
        case .invalidStatusCode(let statusCode):
            return "Status Code Inválido - \(statusCode)"
        case .noData:
            return "Servidor não retornou dados"
        case .decodingError:
            return "Decoding Error :("
        }
    }
}
