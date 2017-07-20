//
//  JaldiPayByCardTask.swift
//  Jaldi
//
//  Created by Admin User on 7/20/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper
import Stripe

class JaldiPayByCardTask: JaldiOperation {
    typealias Output = String
    
    var stpToken : STPToken
    var amount : Int
    
    init(stpToken: STPToken, amount : Int) {
        self.stpToken = stpToken
        self.amount = amount
    }
    
    var request: JaldiRequest {
        return OrderRequest.payByCard(token: stpToken, amount: amount)
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
