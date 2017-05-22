//
//  JaldiRequest.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/18/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import Alamofire
public protocol JaldiRequest {
   
    /// Relative path of the endpoint we want to call (ie. `/users/login`)
    var path			: String				{ get }
    
    /// This define the HTTP method we should use to perform the call
    /// We have defined it inside an String based enum called `HTTPMethod`
    /// just for clarity
    var method		: HTTPMethod			{ get }
    
    /// These are the parameters we need to send along with the call.
    /// Params can be passed into the body or along with the URL
    var parameters	: RequestParams			{ get }
    
    /// You may also define a list of headers to pass along with each request.
    var headers		: [String: String]?		{ get }
    
//    /// What kind of data we expect as response
//    var dataType		: DataType				{ get }
 
}

public enum RequestParams {
    case body(_ : [String: Any]?)
    case url(_ : [String: Any]?)
}
