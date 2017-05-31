//
//  JaldiOrderByIdTask.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/31/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper
class JaldiOrderByIdTask: JaldiOperation {
    typealias Output = JaldiOrder
    
    var orderId: Int

    
    init(orderId: Int) {
        self.orderId = orderId
    }
    
    var request: JaldiRequest {
        return OrderRequest.orderById(orderId: self.orderId)
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
