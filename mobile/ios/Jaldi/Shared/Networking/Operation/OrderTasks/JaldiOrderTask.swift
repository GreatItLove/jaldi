//
//  JaldiOrderTask.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/24/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper
class JaldiOrderTask: JaldiOperation {
    
    typealias Output = JaldiOrder
    var type: String
    var workers: Int
    var address: String
    var comment: String
    var hours: Int
    var cost: Float
    var latitude: Double
    var longitude: Double
    var paymentType: String
    var orderDate: Date
    var city: String
    var country: String
    
    init(type: String,
         workers: Int,
         address: String,
         comment: String,
         hours: Int,
         cost: Float,
         latitude: Double,
         longitude: Double,
         paymentType: String,
         orderDate: Date,
         city:String,
         country:String)
    {
        self.type = type
        self.workers = workers
        self.address = address
        self.comment = comment
        self.hours = hours
        self.cost = cost
        self.latitude = latitude
        self.longitude = longitude
        self.paymentType = paymentType
        self.orderDate = orderDate
        self.city = city
        self.country = country
        
    }
    convenience init?(bookingObject:BookingObject) {
        guard let latitude = UserProfile.currentProfile.user?.latitude,
            let longitude = UserProfile.currentProfile.user?.longitude else{
                return nil
        }
        let bookingAddress = UserProfile.currentProfile.user?.address ?? ""
        let bookingComment = bookingObject.description ?? ""
        let bookingCity = UserProfile.currentProfile.user?.city ?? ""
        let bookingCountry = UserProfile.currentProfile.user?.country ?? ""
        self.init(type: "CLEANER", workers: 1, address: bookingAddress, comment:bookingComment, hours: bookingObject.bookingDetails.hours, cost: bookingObject.cost, latitude: latitude, longitude: longitude, paymentType: "CASH", orderDate: bookingObject.bookingTime ?? Date(),city:bookingCity,country:bookingCountry)
    }
    
    var request: JaldiRequest {
        
        let orderDateStr = self.orderDate.dateStringWith(format: AppDateFormats.appDateFormat)
        let orderDict  = ["type" : type,
                          "workers" : workers,
                          "address" : address,
                          "comment" : comment,
                          "hours" : hours,
                          "cost" : cost,
                          "latitude" : latitude,
                          "longitude" : longitude,
                          "paymentType" : paymentType,
                          "city" : city,
                          "country" : country,
                          "orderDate" : orderDateStr] as [String : Any]
        return OrderRequest.order(orderDict: orderDict)
    }
    
    func execute(in dispatcher: Dispatcher,
                 taskCompletion: ((_ result:Output?)->Void)!,
                 completionError: ((_ error:Error?, _ statusCode:Int?)->Void)!){
        
        let networkDispatcher =  NetworkDispatcher.defaultDispatcher()
        networkDispatcher.execute(request: request,
                                  completion: { (response) -> Void in
                                    
                                    switch response {
                                    case .value(let value):
                                        guard let orderJson  = value as? [String : AnyObject] else {
                                            taskCompletion(nil)
                                            return
                                        }
                                        let order  = Mapper<JaldiOrder>().map(JSON: orderJson)
                                        taskCompletion(order)
                                    case .error(let statuseCode, let error):
                                        completionError(error,statuseCode)
                                    }
        })
    }
}
