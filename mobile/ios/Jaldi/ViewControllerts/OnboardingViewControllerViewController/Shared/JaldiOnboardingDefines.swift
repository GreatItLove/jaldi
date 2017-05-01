//
//  JaldiOnboardingDefines.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 4/30/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
enum OnBoardingState: Int {
    case zip
    case email
}

struct OnBoardingPlaceholderText {
    static let zip = "Zip Code"
    static let email = "Email"
    static  func onBoardingPlaceholderTextFor(onBoardingState:OnBoardingState)->String{
        switch onBoardingState {
        case .zip:
            return OnBoardingPlaceholderText.zip
        case .email:
            return OnBoardingPlaceholderText.email
        }
    }
}
