//
//  JaldiSendVerificationTask.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/19/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper
class JaldiSendVerificationTask: JaldiOperation {
    typealias Output = MobileVerification
    var recipient: String
    
    init(recipient: String) {
        self.recipient = recipient
    }
    
    var request: JaldiRequest {
    return UserRequests.sendVerification(recipient: self.recipient)
    }
    
    func execute(in dispatcher: Dispatcher,
                 taskCompletion: ((_ result:Output?)->Void)!,
                 completionError: ((_ error:Error?, _ statusCode:Int?)->Void)!){
        
        let networkDispatcher =  NetworkDispatcher.defaultDispatcher()
        networkDispatcher.execute(request: request,
                                  completion: { (response) -> Void in
                                    
                                    switch response {
                                    case .value(let value):
                                        guard let verificationJson  = value as? [String : AnyObject] else {
                                            taskCompletion(nil)
                                            return
                                        }
                                        let mobileVerification  = Mapper<MobileVerification>().map(JSON: verificationJson)
                                        taskCompletion(mobileVerification)
                                    case .error(let statuseCode, let error):
                                        completionError(error,statuseCode)
                                        
                                    }
        })
    }
}
