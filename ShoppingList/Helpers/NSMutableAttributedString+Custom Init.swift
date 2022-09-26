//
//  NSMutableAttributedString+Custom Init.swift
//  ShoppingList
//
//  Created by Giuliano Accorsi on 23/09/22.
//

import UIKit

extension NSMutableAttributedString {

    convenience init (fullString: String, fullStringColor: UIColor, subString: String, subStringColor: UIColor) {
        let rangeOfSubString = (fullString as NSString).range(of: subString)
        let rangeOfFullString = NSRange(location: 0, length: fullString.count)
        let attributedString = NSMutableAttributedString(string: fullString)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: fullStringColor,
                                      range: rangeOfFullString)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: subStringColor,
                                      range: rangeOfSubString)

        self.init(attributedString: attributedString)
    }
}
