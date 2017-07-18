//
//  JladiOrderPartial.swift
//  Jaldi
//
//  Created by Sedrak Dalaloyan on 6/5/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper
class JaldiWorker:Mappable {
    
    var user: JaldiUser?
    var rating: Float?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        user      <- map["user"]
        rating      <- map["rating"]
    }
}
