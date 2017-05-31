//
//  JladiOrder+Helper.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/30/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
enum OrderRatingState: Int {
    case none
    case comment
    case rate
    case finished
}
extension JaldiOrder {
    var orderState:JaldiOrderState {
        get {
            guard let order_id = self.orderId else {
                return JaldiOrderState.enRoute
            }
            switch order_id {
            case let x where x > 50:
                return JaldiOrderState.finished
            case let x where x > 40:
                return JaldiOrderState.enRoute
            case let x where x > 30:
                return JaldiOrderState.tidyingUp
            case let x where x > 20:
                return JaldiOrderState.working
            default:
                return JaldiOrderState.enRoute
            }
        }
    }
    var homeCategory:HomeCategory {
        get {
            guard let order_type = self.type else {
                return HomeCategory.homeCleaning
            }
            switch order_type {
            case "CLEANER":
                return HomeCategory.homeCleaning
            case "PAINTER":
                return HomeCategory.painter
            default:
                return HomeCategory.homeCleaning
            }
        }
    }
    var orderRatingState:OrderRatingState {
        get {
            guard orderState == .finished else {
                return OrderRatingState.none
            }
            guard let _ = comment else {
              return OrderRatingState.comment
            }
            guard let _ = rate else {
                return OrderRatingState.rate
            }
            return OrderRatingState.finished
        }
    }

    
    
}
