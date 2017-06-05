//
//  Environment.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/18/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
public struct Environment {
//    static let baseUrl = "http://dev.jaldi.pro"
    static let baseUrl = "http://dev.jaldi.pro"
    
    static let imageBaseUrl = baseUrl + "/getFile?id="
    
    static func defaultEnvironment() -> Environment {
        var env = Environment("Default", host: baseUrl )
        env.headers = ["Content-Type": "application/json"]
        if let token =  env.autToken {
            env.headers = ["Authorization": token]
        }
        return env
    }
    
    let autTokenKey = "defaul_autTokenKey"
   
    /// Name of the environment
    public var name: String
    
    /// Base URL of the environment
    public var host: String
    
    /// This is the list of common headers which will be part of each Request
    /// Some headers value maybe overwritten by Request's own headers
    public var headers: [String: String] = [:]
    
    /// Name of the environment
    public var autToken: String? {
        get {
            return UserDefaults.standard.object(forKey: autTokenKey) as? String
        }
        set{
            let value  = newValue?.replacingOccurrences(of: "Bearer ", with: "")
            let userDefaults  = UserDefaults.standard
            userDefaults.setValue(value, forKey: autTokenKey)
            userDefaults.synchronize()
        }
    }
    

    /// Initialize a new Environment
    ///
    /// - Parameters:
    ///   - name: name of the environment
    ///   - host: base url
    public init(_ name: String, host: String) {
        self.name = name
        self.host = host
        
    }
}
