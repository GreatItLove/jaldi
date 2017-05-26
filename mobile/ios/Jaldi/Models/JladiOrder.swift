//
//  JladiOrder.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/24/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper
class JaldiOrder:Mappable {
    var orderId: Int?
    var address: String?
    var cost: Float?
    var type: String?
    var workers: Int?
    var hours: Int?
    var latitude: Double?
    var longitude: Double?
    var paymentType: String?
    var status: String?
    var orderDate: Date?
    var creationDate: Date?
    var user: JaldiUser?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        orderId        <- map["id"]
        address      <- map["address"]
        cost      <- map["cost"]
        type        <- map["type"]
        workers      <- map["workers"]
        hours      <- map["hours"]
        latitude        <- map["latitude"]
        longitude      <- map["longitude"]
        paymentType      <- map["paymentType"]
        status      <- map["status"]
        creationDate    <- (map["formattedCreationDate"], DateFormatterTransform(dateFormatter: Date.appDateFormater))
        orderDate    <- (map["formattedOrderDate"], DateFormatterTransform(dateFormatter: Date.appDateFormater))
        user      <- map["user"]
    }
}

