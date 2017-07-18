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
    
    static func isValid(cardNumber:String) -> Bool {
        return cardNumber.characters.count > 0
    }
    static func isValid(cvc:String) -> Bool {
        return cvc.characters.count == 4 && self.isNumeric(inputString: cvc)
    }
    static func isValid(cardDate:String) -> Bool {
       let components =  cardDate.components(separatedBy: "/")
        if components.count != 2 {
          return false
        }
        let month = components[0]
        let year = components[1]
        if month.characters.count != 2 || year.characters.count != 2 {
           return false
        }
        if !isNumeric(inputString: month) || !isNumeric(inputString: year) {
           return false
        }
        
        if let monthInt = Int(month) {
          return (monthInt >= 0 && monthInt <= 12)
        }
        return false
    }
    static func isValid(phone:String) -> Bool {
        var isValid = false
            let text = phone as NSString
            let  strippedNumber =  text.replacingOccurrences(of: "[^0-9,+]", with: "", options: NSString.CompareOptions.regularExpression, range: NSMakeRange(0, text.length)) as NSString
            isValid = (strippedNumber.length == 11 || strippedNumber.length == 12)
        return isValid
        }
    
    //MARK:HELPER
    static func correct(phoneNumber:String) -> String {
        var result:NSString = ""
        let text  = phoneNumber as NSString
        let  strippedNumber =  text.replacingOccurrences(of: "[^0-9,+]", with: "", options: NSString.CompareOptions.regularExpression, range: NSMakeRange(0, text.length)) as NSString
        for location in 0..<strippedNumber.length {
            let  character = strippedNumber.character(at: location) as  unichar
            switch location {
            case 0:
                if UnicodeScalar(character) != "+" {
                    result = result.appendingFormat("+%C", character)
                }else{
                    result = result.appendingFormat("%C", character)
                }
            case 3:
                result = result.appendingFormat("%C ", character)
            case 8:
                result = result.appendingFormat("-%C", character)
            default:
                result = result.appendingFormat("%C", character)
            }
        }
        return result as String
    }
//    switch location {
//    case 0:
//    result = result.appendingFormat("(%C", character)
//    case 2:
//    result = result.appendingFormat("%C)", character)
//    case 6:
//    result = result.appendingFormat("-%C", character)
//    default:
//    result = result.appendingFormat("%C", character)
//    }

}
