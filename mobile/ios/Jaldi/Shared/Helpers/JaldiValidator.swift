//
//  JaldiValidator.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 4/30/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation

struct JaldiValidator {
    static func isNumeric(inputString:String) -> Bool{
        var isValid = false
        let alphaNumbersSet = CharacterSet.decimalDigits
        let stringSet = CharacterSet(charactersIn: inputString)
        isValid = alphaNumbersSet.isSuperset(of: stringSet)
        return isValid
    }
    static func isValidEmail(inputString:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: inputString)
    }

}
