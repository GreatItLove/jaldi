
//
//  JaldiUpdateTokenTask.swift
//  Jaldi
//
//  Created by Sedrak Dalaloyan on 6/7/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper
class JaldiUpdateTokenTask: JaldiOperation {
    typealias Output = String
    
    var token: String
    var type: String = "APNS"
    
    init(token: String) {
        self.token = token
    }
    
    var request: JaldiRequest {
        return UserRequests.updateDeviceToken(token: self.token, type: self.type)
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
