//
//  JaldiUpdateLocationTask.swift
//  Jaldi
//
//  Created by Mnats Karakhanyan on 5/31/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
class JaldiUpdateLocationTask: JaldiOperation {
    typealias Output = String
    var latitude:  Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var request: JaldiRequest {
        return UserRequests.updateLocation(latitude: self.latitude, longitude: self.longitude)
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
