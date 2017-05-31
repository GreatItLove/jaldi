//
//  JaldiOrderFeedbackTask.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/31/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper
class JaldiOrderFeedbackTask: JaldiOperation {
    typealias Output = String
    
    var orderId: Int
    var userFeedback: String
    
    init(orderId: Int, userFeedback: String) {
        self.orderId = orderId
        self.userFeedback = userFeedback
    }
    
    var request: JaldiRequest {
        return OrderRequest.orderFeedback(orderId: self.orderId, userFeedback: self.userFeedback)
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
