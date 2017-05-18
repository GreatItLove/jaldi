//
//  JaldiOnboardingDefines.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 4/30/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
enum OnBoardingState: Int {
    case phone
    case confirmationCode
    case email
    case password
}

struct OnBoardingPlaceholderText {
    static let phone = "Phone"
    static let confirmationCode = "Confirmation Code"
    static let password = "Password"
    static let email = "Email"
    static  func onBoardingPlaceholderTextFor(onBoardingState:OnBoardingState)->String{
        switch onBoardingState {
        case .phone:
            return OnBoardingPlaceholderText.phone
        case .confirmationCode:
            return OnBoardingPlaceholderText.confirmationCode
        case .email:
            return OnBoardingPlaceholderText.email
        case .password:
            return OnBoardingPlaceholderText.password
        }
    }
}


struct OnBoardingStateTitle {
    static let phone = "What's your phone?"
    static let confirmationCode = "Confirmation Code"
    static let password = "What's your password?"
    static let email = "What's your email?"
    static  func onBoardingStateTitleFor(onBoardingState:OnBoardingState)->String{
        switch onBoardingState {
        case .phone:
            return OnBoardingStateTitle.phone
        case .confirmationCode:
            return OnBoardingStateTitle.confirmationCode
        case .email:
            return OnBoardingStateTitle.email
        case .password:
            return OnBoardingStateTitle.password
        }
    }
}
