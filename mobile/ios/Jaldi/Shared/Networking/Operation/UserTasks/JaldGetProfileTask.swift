//
//  JaldGetProfileTask.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/19/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper
class JaldGetProfileTask: JaldiOperation {
    typealias Output = JaldiUser


    var request: JaldiRequest {
        return UserRequests.profile
    }
    
    func execute(in dispatcher: Dispatcher,
                 taskCompletion: ((_ result:Output?)->Void)!,
                 completionError: ((_ error:Error?, _ statusCode:Int?)->Void)!){
        
        let networkDispatcher =  NetworkDispatcher.defaultDispatcher()
        networkDispatcher.execute(request: request,
                                  completion: { (response) -> Void in
                                    
                                    switch response {
                                    case .value(let value):
                                        guard let userJson  = value as? [String : AnyObject] else {
                                            taskCompletion(nil)
                                            return
                                        }
                                        let user  = Mapper<JaldiUser>().map(JSON: userJson)
                                        taskCompletion(user)
                                    case .error(let statuseCode, let error):
                                        completionError(error,statuseCode)
                                        
                                    }
        })
    }
}
