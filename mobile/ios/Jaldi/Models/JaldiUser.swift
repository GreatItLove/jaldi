//
//  JaldiOnboardingModel.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 4/30/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
class JaldiUser {
    var zip:String?
    var email:String?
    var phone:String?
    var confirmationCode:String?
    var password:String?
    var address:String?
    
    
    func canLoginAsGuest() -> Bool {
        guard let _ = password, let _ = email else{
         return false
        }
        return true //AvailableZipCodes.zipCodeIsAvailable(zipCode: zipCode)
    }
}


