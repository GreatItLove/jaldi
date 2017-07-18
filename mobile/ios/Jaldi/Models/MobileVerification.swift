//
//  MobileVerification.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/19/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper
class MobileVerification:Mappable{
    
    var verificationId: Int?
    var verificationCode:String?
    var recipient: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        verificationId        <- map["id"]
        verificationCode      <- map["code"]
        recipient      <- map["recipient"]
    }
    
}
