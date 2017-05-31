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
    case myOrders
    case orderRate(orderId:Int, userRating:Float)
    case orderFeedback(orderId:Int, userFeedback:String)
    case orderById(orderId:Int)
    case cancel(orderId:Int)
    
    public var path: String {
        switch self {
        case .order(_):
            return "rest/order"
        case .myOrders:
            return "rest/order/my"
        case .orderRate(_,_):
            return "rest/order/rate"
        case .orderFeedback(_,_):
            return "rest/order/feedback"
        case .orderById(let orderId):
            return "rest/order/\(orderId)"
        case .cancel(let orderId):
            return "rest/order/cancel/\(orderId)"

        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .order(_):
            return .post
        case .myOrders:
            return .get
        case .orderRate(_,_):
            return .put
        case .orderFeedback(_,_):
            return .put
        case .orderById(_):
            return .get
        case .cancel(_):
            return .put

        }
    }
    
    public var parameters: RequestParams {
        switch self {
        case .order(let orderDict):
            return .body(orderDict)
        case .myOrders:
           return .body(nil)
        case .orderRate(let orderId , let userRating):
            return .body(["id" : orderId,"userRating" : userRating])
        case .orderFeedback(let orderId , let userFeedback):
            return .body(["id" : orderId,"userFeedback" : userFeedback])
        case .orderById(_):
            return .body(nil)
        case .cancel(_):
            return .body(nil)

        }
    }

    public var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
    
}
