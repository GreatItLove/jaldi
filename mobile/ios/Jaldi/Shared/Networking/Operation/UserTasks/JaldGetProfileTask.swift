//
//  JaldGetProfileTask.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/19/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
class JaldGetProfileTask: JaldiOperation {
    typealias Output = String


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
                                    case .value(_):
                                        taskCompletion("success")
                                    case .error(let statuseCode, let error):
                                        completionError(error,statuseCode)
                                        
                                    }
        })
    }
}
