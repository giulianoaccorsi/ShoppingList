//
//  ViewConfiguration.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import Foundation

protocol ViewConfiguration {
    func buildViewHierarchy()
    func setUpConstraints()
    func setUpAdditionalConfiguration()
    func setUpView()
}

extension ViewConfiguration {
    func setUpView() {
        buildViewHierarchy()
        setUpConstraints()
        setUpAdditionalConfiguration()
    }
}
