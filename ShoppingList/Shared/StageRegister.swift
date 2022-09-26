//
//  StageRegister.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import Foundation

enum StageRegister: Int {

    case firstStage
    case secondStage
    case thirdStage
    case fourthStage
    case fivethStage
    case sixthStage

    var description: (label: String, textWithColor: String) {
        switch self {
        case .firstStage:
            return ("Etapa 01 de 07", "01")
        case .secondStage:
            return ("Etapa 02 de 07", "02")
        case .thirdStage:
            return ("Etapa 03 de 07", "03")
        case .fourthStage:
            return ("Etapa 04 de 07", "04")
        case .fivethStage:
            return ("Etapa 05 de 07", "05")
        case .sixthStage:
            return ("Etapa 06 de 07", "06")
        }
    }
}
