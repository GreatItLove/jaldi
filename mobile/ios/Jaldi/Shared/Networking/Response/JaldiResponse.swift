//
//  JaldiResponse.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/19/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
public enum JaldiResponse {
    case value(_: AnyObject?)
    case error(_: Int?, _: Error?)
    
    init(_ response: (isSuccess:Bool, value:AnyObject? ,r: HTTPURLResponse?, data: Data?, error: Error?), for request: JaldiRequest) {
        guard let statusCode = response.r?.statusCode,  statusCode == 200 else {
            print(request.path)
            let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)
            print("response.data ---  \(datastring ?? "")")
            print("response ---  \(response.r)")
            print("response.result.error ---  \(response.error)")
            
            if response.isSuccess {
                guard let errorDict  = response.value as? [String : AnyObject] else {
                    self = .error(response.r?.statusCode, response.error)
                    return
                }
                guard let error = errorDict["error"] as? String ,  let message = errorDict["message"] as? String else{
                  self = .error(response.r?.statusCode, response.error)
                    return
                }
                self = .error(response.r?.statusCode, NetworkErrors.networkMessage(error_: error, message: message))
            }else{
                self = .error(response.r?.statusCode, response.error)
            }
            return
        }
        if response.isSuccess {
            self = .value(response.value)
        } else {
            if case UserRequests.login(username: _, password: _ ) = request {
                if  let authorization = response.r?.allHeaderFields["Authorization"] as? String{
                    var env = Environment.defaultEnvironment()
                    env.autToken = authorization
                    self = .value("" as AnyObject)
                    return
                }
            }
            guard let _ = response.data else {
                self = .error(response.r?.statusCode, NetworkErrors.noData)
                return
            }
           self = .error(response.r?.statusCode, response.error)
        }
    }
}
