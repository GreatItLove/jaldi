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
            guard let status = self.status else {
                return JaldiOrderState.enRoute
            }
            switch status {
            case "EN_ROUTE":
                return JaldiOrderState.enRoute
            case "WORKING":
                return JaldiOrderState.working
            case "TIDYING_UP":
                return JaldiOrderState.tidyingUp
            case "FINISHED":
                return JaldiOrderState.finished
            case "CANCELED":
                return JaldiOrderState.canceled
            case "CREATED":
                return JaldiOrderState.created
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
            guard orderState == .finished
                && (ratingInProgress ?? false
                    || userRating == nil)  else {
                return OrderRatingState.none
            }
            guard let _ = userRating else {
                return OrderRatingState.rate
            }
            guard let _ = userFeedback else {
              return OrderRatingState.comment
            }
            return OrderRatingState.finished
        }
    }
}
