//
//  JaldiOnboardingModel.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 4/30/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper
class JaldiUser:Mappable {
    var name:String?
    var zip:String?
    var email:String?
    var phone:String?
    var confirmationCode:String?
    var password:String?
    var address:String?
    var profileImageId:String?
    var role:String?
    var type:String?
    var creationDate:Date?
    
    var active: Bool?
    var deleted: Bool?
    var userId: Int?
    
    required init?(map: Map) {
    }
    class func emptyUser() -> JaldiUser{
        return Mapper<JaldiUser>().map(JSON: ["":""])!
    }
    
    func mapping(map: Map) {
        userId        <- map["id"]
        active      <- map["active"]
        deleted      <- map["deleted"]
        email        <- map["email"]
        name      <- map["name"]
        password      <- map["password"]
        phone        <- map["phone"]
        profileImageId      <- map["profileImageId"]
        role      <- map["role"]
        type      <- map["type"]
    }
    
    func canLoginAsGuest() -> Bool {
        guard let _ = password, let _ = email else{
         return false
        }
        return true //AvailableZipCodes.zipCodeIsAvailable(zipCode: zipCode)
    }
}


