//
//  JaldRegistrationTask.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/19/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import ObjectMapper
class JaldiRegistrationTask: JaldiOperation {
    typealias Output = JaldiUser
    var registrationModel: JaldiRegistration

    
    init(registrationModel: JaldiRegistration) {
        self.registrationModel = registrationModel
    }
    var request: JaldiRequest {
        let userParams  = (name: self.registrationModel.name ?? "", email: self.registrationModel.email ?? "", phone: self.registrationModel.recipient ?? "", password: self.registrationModel.password ?? "")
        let verification = (verificationId: self.registrationModel.mobileVerification?.verificationId ?? 0, verificationCode: self.registrationModel.mobileVerification?.verificationCode ?? "")
        return UserRequests.register(verification: verification , user: userParams )
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
