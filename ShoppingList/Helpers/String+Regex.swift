//
//  String+Regex.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import Foundation
// swiftlint:disable all
extension String {
    func isValidEmail() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
                                                options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        } catch {
            return false
        }
    }

    func isValidDate() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^\\d{1,2}[\\/-]\\d{1,2}[\\/-]\\d{4}$",
                                                options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        } catch {
            return false
        }
    }

    func isValidNumber() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "\\([0-9]{2}\\) [0-9]{4,5}-[0-9]{4}",
                                                options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        } catch {
            return false
        }

    }

    func isValidCEP() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[0-9]{5}-[0-9]{3}",
                                                options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        } catch {
            return false
        }

    }

    func isValidPassword() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9]{8,16}$",
                                                options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        } catch {
            return false
        }

    }
    
    func isValidCPF() -> Bool {
        let cpf = self.onlyNumbers()
                guard cpf.count == 11 else { return false }

                let i1 = cpf.index(cpf.startIndex, offsetBy: 9)
                let i2 = cpf.index(cpf.startIndex, offsetBy: 10)
                let i3 = cpf.index(cpf.startIndex, offsetBy: 11)
                let d1 = Int(cpf[i1..<i2])
                let d2 = Int(cpf[i2..<i3])

                var temp1 = 0, temp2 = 0

                for i in 0...8 {
                    let start = cpf.index(cpf.startIndex, offsetBy: i)
                    let end = cpf.index(cpf.startIndex, offsetBy: i+1)
                    let char = Int(cpf[start..<end])

                    temp1 += char! * (10 - i)
                    temp2 += char! * (11 - i)
                }

                temp1 %= 11
                temp1 = temp1 < 2 ? 0 : 11-temp1

                temp2 += temp1 * 2
                temp2 %= 11
                temp2 = temp2 < 2 ? 0 : 11-temp2

                return temp1 == d1 && temp2 == d2
    }

    func onlyNumbers() -> String {
            guard !isEmpty else { return "" }
            return replacingOccurrences(of: "\\D",
                                        with: "",
                                        options: .regularExpression,
                                        range: startIndex..<endIndex)
        }
}
