//
//  JaldiOnboardingModel.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 4/30/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
class JaldiOnboardingModel {
    var zip:String?
    var email:String?
    
    func canLoginAsGuest() -> Bool {
        guard let zipCode = zip, let _ = email else{
         return false
        }
        return AvailableZipCodes.zipCodeIsAvailable(zipCode: zipCode)
    }
}


