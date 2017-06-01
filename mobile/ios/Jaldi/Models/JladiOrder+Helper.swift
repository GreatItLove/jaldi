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

enum JaldiStatus: String {
    case created = "CREATED"
    case assigned = "ASSIGNED"
    case canceled = "CANCELED"
    case enRoute = "EN_ROUTE"
    case working = "WORKING"
    case tidyingUp = "TIDYING_UP"
    case finished = "FINISHED"
}

enum JaldiType: String {
    case homeCleaning = "CLEANER"
    case carpenter = "CARPENTER"
    case electrician = "ELECTRICIAN"
    case mason = "MASON"
    case painter = "PAINTER"
    case plumber = "PLUMBER"
    case acTechnical = "AC_TECHNICALL"
}


extension JaldiOrder {
    var orderState:JaldiOrderState {
        get {
            guard let status = self.status else {
                return JaldiOrderState.created
            }
            switch status {
            case JaldiStatus.created.rawValue:
                return JaldiOrderState.created
            case JaldiStatus.assigned.rawValue:
                return JaldiOrderState.assigned
            case JaldiStatus.canceled.rawValue:
                return JaldiOrderState.canceled
            case JaldiStatus.enRoute.rawValue:
                return JaldiOrderState.enRoute
            case JaldiStatus.working.rawValue:
                return JaldiOrderState.working
            case JaldiStatus.tidyingUp.rawValue:
                return JaldiOrderState.tidyingUp
            case JaldiStatus.finished.rawValue:
                return JaldiOrderState.finished
            default:
                return JaldiOrderState.created
            }
        }
    }
    var homeCategory:HomeCategory {
        get {
            guard let order_type = self.type else {
                return HomeCategory.homeCleaning
            }
            switch order_type {
            case JaldiType.homeCleaning.rawValue:
                return HomeCategory.homeCleaning
            case JaldiType.carpenter.rawValue:
                return HomeCategory.carpenter
            case JaldiType.electrician.rawValue:
                return HomeCategory.electrician
            case JaldiType.mason.rawValue:
                return HomeCategory.mason
            case JaldiType.plumber.rawValue:
                return HomeCategory.plumber
            case JaldiType.acTechnical.rawValue:
                return HomeCategory.acTechnical
            case JaldiType.painter.rawValue:
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
            guard let _ = userFeedback else {
              return OrderRatingState.comment
            }
            guard let _ = userRating else {
                return OrderRatingState.rate
            }
            return OrderRatingState.finished
        }
    }
}
