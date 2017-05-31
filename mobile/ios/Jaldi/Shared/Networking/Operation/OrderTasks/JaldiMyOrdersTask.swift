//
//  JaldiMyOrdersTask.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/31/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper
class JaldiMyOrdersTask: JaldiOperation {
    typealias Output = [JaldiOrder]
   
    var request: JaldiRequest {
        return OrderRequest.myOrders
    }
    
    func execute(in dispatcher: Dispatcher,
                 taskCompletion: ((_ result:Output?)->Void)!,
                 completionError: ((_ error:Error?, _ statusCode:Int?)->Void)!){
        
        let networkDispatcher =  NetworkDispatcher.defaultDispatcher()
        networkDispatcher.execute(request: request,
                                  completion: { (response) -> Void in
                                    
                                    switch response {
                                    case .value(let value):
                                        guard let orderlist  = value as? [[String : AnyObject]] else {
                                            taskCompletion(nil)
                                            return
                                        }
                                        guard let orders  = Mapper<JaldiOrder>().mapArray(JSONArray: orderlist) else{
                                            taskCompletion([JaldiOrder]())
                                            return
                                        }
                                        taskCompletion(orders)
                                    case .error(let statuseCode, let error):
                                        completionError(error,statuseCode)
                                    }
        })
    }
}
