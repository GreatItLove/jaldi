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
    
    typealias Output = JladiOrder
    var type: String
    var workers: Int
    var address: String
    var hours: Int
    var cost: Float
    var latitude: Double
    var longitude: Double
    var paymentType: String
    var orderDate: Date
    
    init(type: String,
         workers: Int,
         address: String,
         hours: Int,
         cost: Float,
         latitude: Double,
         longitude: Double,
         paymentType: String,
         orderDate: Date)
    {
        self.type = type
        self.workers = workers
        self.address = address
        self.hours = hours
        self.cost = cost
        self.latitude = latitude
        self.longitude = longitude
        self.paymentType = paymentType
        self.orderDate = orderDate
    }
    
    var request: JaldiRequest {
        
        let orderDateStr = self.orderDate.dateStringWith(format: "dd/MM/YYYY HH:mm")
        let orderDict  = ["type" : type,
                          "workers" : workers,
                          "address" : address,
                          "hours" : hours,
                          "cost" : cost,
                          "latitude" : latitude,
                          "longitude" : longitude,
                          "paymentType" : paymentType,
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
                                        let order  = Mapper<JladiOrder>().map(JSON: orderJson)
                                        taskCompletion(order)
                                    case .error(let statuseCode, let error):
                                        completionError(error,statuseCode)
                                        
                                    }
        })
    }
}
