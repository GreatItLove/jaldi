//
//  UserRequest.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/18/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import Alamofire
public enum UserRequests: JaldiRequest {
    
    case login(username: String, password: String)
    case forgot(email: String)
    case profile
    case sendVerification(recipient:String)
    case register(verification: (verificationId:Int, verificationCode:String) ,
                  user:(name:String,email:String,phone:String,password:String))
    case updateLocation(latitude:Double, longitude:Double)
    case updateDeviceToken(token:String, type:String)
    
    public var path: String {
        switch self {
        case .login(_,_):
            return "loginjwt"
        case .forgot(_):
            return "forgot"
        case .profile:
            return "rest/profile/0"
        case .register(_, _):
            return "rest/mobile/register"
        case .sendVerification(_):
            return "rest/mobile/sendVerification"
        case .updateLocation(_,_):
            return "rest/profile/location"
        case .updateDeviceToken(_,_):
            return "rest/mobile/updateDeviceToken"
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .login(_,_):
            return .post
        case .forgot(_):
            return .post
        case .profile:
            return .get
        case .register(_, _):
            return .post
        case .sendVerification(_):
            return .post
        case .updateLocation(_,_):
            return .put
        case .updateDeviceToken(_,_):
            return .put
        }
    }
    
    public var parameters: RequestParams {
        switch self {
        case .login(let username, let password):
            return .body(["username" : username, "password" : password])
        case .forgot(let email):
            return .body(["email" : email])
        case .profile:
            return .body(nil)
        case .register(let verification,let user):
            return  .body(["verificationId" : verification.verificationId,
                           "verificationCode" : verification.verificationCode,
                           "user": ["name" : user.name,
                                    "email" : user.email,
                                    "phone" : user.phone,
                                    "password" : user.password]])
        case .sendVerification(let recipient):
            return .body(["recipient" : recipient])
        case .updateLocation(let latitude , let longitude):
            return .body(["latitude" : latitude,"longitude" : longitude])
        case .updateDeviceToken(let token , let type):
            return .body(["token" : token,"type" : type])
        }
    }

    public var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }

}
