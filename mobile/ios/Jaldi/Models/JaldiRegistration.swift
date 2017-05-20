//
//  JaldiRegistration.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/20/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
class JaldiRegistration {
    var name:String?
    var email:String?
    var phone:String?
    var confirmationCode:String?
    var password:String?
    var confirmPassword:String?
    var mobileVerification:MobileVerification?
    var recipient:String? {
        get {
            guard let phoneNumber = self.phone else{
                return nil
            }
            let text = phoneNumber as NSString
            let  strippedNumber =  text.replacingOccurrences(of: "[^0-9,+]", with: "", options: NSString.CompareOptions.regularExpression, range: NSMakeRange(0, text.length)) as String
            return strippedNumber
        }
    }
    
    var isPhoneNumberVerified:Bool {
        guard let phoneNumber = self.recipient , let verifiedRecipient = mobileVerification?.recipient else{
            return false
        }
       return phoneNumber == verifiedRecipient.replacingOccurrences(of: "+", with: "")
    }
    var isConfirmationCodeValid:Bool {
        guard let code = self.confirmationCode , let verificationCode = mobileVerification?.verificationCode else{
            return false
        }
        return code == verificationCode
    }
    var isPasswordConfirmationValid:Bool {
        guard let pass = self.password , let confirm = self.confirmPassword else{
            return false
        }
        return pass == confirm
    }
    

    func canLoginAsGuest() -> Bool {
        guard let _ = password, let _ = email else{
            return false
        }
        return true //AvailableZipCodes.zipCodeIsAvailable(zipCode: zipCode)
    }
}
