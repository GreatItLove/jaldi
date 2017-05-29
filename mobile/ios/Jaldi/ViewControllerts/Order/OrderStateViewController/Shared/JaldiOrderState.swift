//
//  JaldiOrderState.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/25/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
enum JaldiOrderState: Int {
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
        static let enRoute = "En route"
        static let working = "Working"
        static let tidyingUp = "Tidyng Up"
        static let finished = "Finshed"
    }
    struct CheckMarkIcons {
        static let unchecked = "radio_off"
        static let green = "green_success_mark"
        static let blue = "blue_success_mark"
    }
    
    static func orderStateTitleFor(orderState:JaldiOrderState) -> String {
        switch orderState {
        case .enRoute:
            return OrderStateTitle.enRoute
        case .working:
            return OrderStateTitle.working
        case .tidyingUp:
            return OrderStateTitle.tidyingUp
        case .finished:
            return OrderStateTitle.finished
        }
    }
    
    static func orderStateIconeFor(orderState:JaldiOrderState , selected:Bool) -> String {
        if !selected {
          return CheckMarkIcons.unchecked
        }
        switch orderState {
        case .enRoute, .working:
             return CheckMarkIcons.green
        case .tidyingUp, .finished:
            return CheckMarkIcons.blue
        }
    }
    static func orderStateLabelTitleFor(orderState:JaldiOrderState , selected:Bool) -> String? {
        switch orderState {
        case .enRoute:
            return selected ? nil : "1"
        case .working:
            return selected ? nil : "2"
        case .tidyingUp:
            return "3"
        case .finished:
            return "4"
        }
    }
}
