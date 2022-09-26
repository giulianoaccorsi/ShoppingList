//
//  GetRequestable.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 24/09/22.
//

import Foundation

protocol GetRequestable {
    func get<T: Decodable> (urlString: String, parser: T.Type, onComplete: @escaping (Result<T, ServiceError>) -> Void)
}
