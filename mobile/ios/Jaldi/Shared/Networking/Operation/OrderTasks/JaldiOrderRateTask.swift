//
//  JaldiOrderRateTask.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/31/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper
class JaldiOrderRateTask: JaldiOperation {
    typealias Output = String
    
    var orderId: Int
    var userRating: Float

    init(orderId: Int, userRating: Float) {
        self.orderId = orderId
        self.userRating = userRating
    }
    
    var request: JaldiRequest {
        return OrderRequest.orderRate(orderId: self.orderId, userRating: self.userRating)
    }
    
    func execute(in dispatcher: Dispatcher,
                 taskCompletion: ((_ result:Output?)->Void)!,
                 completionError: ((_ error:Error?, _ statusCode:Int?)->Void)!){
        
        let networkDispatcher =  NetworkDispatcher.defaultDispatcher()
        networkDispatcher.execute(request: request,
                                  completion: { (response) -> Void in
                                    
                                    switch response {
                                    case .value(_):
                                        taskCompletion("Success")
                                    case .error(let statuseCode, let error):
                                        completionError(error,statuseCode)
                                    }
        })
    }
}
