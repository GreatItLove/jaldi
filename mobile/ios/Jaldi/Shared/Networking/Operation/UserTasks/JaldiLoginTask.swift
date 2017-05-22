//
//  JaldiLoginTask.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/19/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation

class JaldiLoginTask: JaldiOperation {
    typealias Output = String
    var username: String
    var password: String
    
    init(user: String, password: String) {
        self.username = user
        self.password = password
       
    }
    
    var request: JaldiRequest {
        return UserRequests.login(username: self.username, password: self.password)
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
