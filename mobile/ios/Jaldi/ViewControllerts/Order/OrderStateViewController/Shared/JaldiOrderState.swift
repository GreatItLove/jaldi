//
//  JaldiOrderState.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/25/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
enum JaldiOrderState: Int {
    case canceled
    case created
    case assigned
    case enRoute
    case working
    case tidyingUp
    case finished
    
    static let allStates = [JaldiOrderState.canceled,
                            JaldiOrderState.created,
                            JaldiOrderState.assigned,
                            JaldiOrderState.enRoute,
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
    
    static func orderStateIconeFor(orderState:JaldiOrderState , selected:Bool) -> String {
        if !selected {
            return CheckMarkIcons.blue
        } else {
            return CheckMarkIcons.green
        }
//        switch orderState {
//        case .enRoute, .working:
//             return CheckMarkIcons.green
//        case .tidyingUp, .finished:
//            return CheckMarkIcons.blue
//        }
    }
    static func orderStateLabelTitleFor(orderState:JaldiOrderState , selected:Bool) -> String? {
        switch orderState {
        case .canceled:
            return selected ? nil : "1"
        case .created:
            return selected ? nil : "1"
        case .assigned:
            return selected ? nil : "1"
        case .enRoute:
            return selected ? nil : "1"
        case .working:
            return selected ? nil : "2"
        case .tidyingUp:
            return selected ? nil : "3"
        case .finished:
            return selected ? nil : "4"
        }
    }
}
