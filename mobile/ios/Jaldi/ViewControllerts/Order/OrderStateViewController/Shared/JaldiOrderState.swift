//
//  JaldiOrderState.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/25/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
enum JaldiOrderState: Int {
    case created
    case assigned
    case canceled
    case enRoute
    case working
    case tidyingUp
    case finished
    
    static let allStates = [JaldiOrderState.enRoute,
                            JaldiOrderState.working,
                            JaldiOrderState.tidyingUp,
                            JaldiOrderState.finished
                            ]
}

struct JaldiOrderStateHeleper {
    struct OrderStateTitle {
        static let created = "Created"
        static let assigned = "Assigned"
        static let enRoute = "En route"
        static let working = "Working"
        static let tidyingUp = "Tidyng Up"
        static let finished = "Finshed"
        static let canceled = "Canceled"
    }
    struct CheckMarkIcons {
        static let unchecked = "radio_off"
        static let green = "green_success_mark"
        static let blue = "blue_success_mark"
    }
    
    static func orderStateTitleFor(orderState:JaldiOrderState) -> String {
        switch orderState {
        case .created:
            return OrderStateTitle.created
        case .assigned:
            return OrderStateTitle.assigned
        case .enRoute:
            return OrderStateTitle.enRoute
        case .working:
            return OrderStateTitle.working
        case .tidyingUp:
            return OrderStateTitle.tidyingUp
        case .finished:
            return OrderStateTitle.finished
        case .canceled:
            return OrderStateTitle.canceled
}
    }
    
    static func orderStateIconeFor(orderState:JaldiOrderState , currentState:JaldiOrderState) -> String? {
        if orderState.rawValue > currentState.rawValue {
            return CheckMarkIcons.unchecked
        } else if orderState.rawValue == currentState.rawValue && currentState != .finished {
            return CheckMarkIcons.blue
        } else {
            return CheckMarkIcons.green
        }
    }
    static func orderStateLabelTitleFor(orderState:JaldiOrderState , currentState:JaldiOrderState) -> String? {
        let showNumber = orderState.rawValue >= currentState.rawValue && currentState != .finished
        switch orderState {
        case .enRoute:
            return showNumber ? "1" : nil
        case .working:
            return showNumber ? "2" : nil
        case .tidyingUp:
            return showNumber ? "3" : nil
        case .finished:
            return showNumber ? "4" : nil
        default:
            return nil
        }
    }
}
