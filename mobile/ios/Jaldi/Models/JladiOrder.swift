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
    var comment: String?
    var address: String?
    var city: String?
    var country: String?
    var userFeedback: String?
    var userRating: Float?
    var workersList: [JaldiWorker]?
    var user: JaldiUser?
    var ratingInProgress: Bool?
    
    
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
        comment      <- map["comment"]
        address      <- map["address"]
        city        <- map["city"]
        country        <- map["country"]
        userFeedback        <- map["userFeedback"]
        userRating        <- map["userRating"]
        creationDate    <- (map["creationDate"], MilisecondDateTransform())
        orderDate    <- (map["orderDate"], MilisecondDateTransform())
        user      <- map["user"]
        workersList      <- map["workersList"]
  
    }
}

