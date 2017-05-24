//
//  OrderRequest.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/24/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import Alamofire
public enum OrderRequest: JaldiRequest {
    
    case order(orderDict:[String:Any])
    
    public var path: String {
        switch self {
        case .order(_):
            return "rest/order"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .order(_):
            return .post
        }
    }
    
    public var parameters: RequestParams {
        switch self {
        case .order(let orderDict):
            return .body(orderDict)
        }
    }

    public var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
    
}
