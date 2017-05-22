//
//  JaldiOnboardingDefines.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 4/30/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
enum RegistrationState: Int {
    case phone
    case name
    case confirmationCode
    case email
    case password
    case confirmPassword
}

struct RegistrationPlaceholderText {
    static let phone = "Phone"
    static let confirmationCode = "Confirmation Code"
    static let password = "Password"
    static let email = "Email"
    static let name = "Name"
    static let confirmPassword = "Confirm Password"
    
    static  func registrationPlaceholderTextFor(registrationState:RegistrationState)->String{
        switch registrationState {
        case .phone:
            return RegistrationPlaceholderText.phone
        case .confirmationCode:
            return RegistrationPlaceholderText.confirmationCode
        case .email:
            return RegistrationPlaceholderText.email
        case .password:
            return RegistrationPlaceholderText.password
        case .name:
            return RegistrationPlaceholderText.name
        case .confirmPassword:
            return RegistrationPlaceholderText.confirmPassword

        }
    }
}

struct RegistrationStateTitle {
    static let phone = "What's your phone?"
    static let name = "What's your name?"
    static let confirmationCode = "Confirmation Code"
    static let password = "What's your password?"
    static let confirmPassword = "Confirm your password?"
    static let email = "What's your email?"
    static  func registrationStateTitleFor(registrationState:RegistrationState)->String{
        switch registrationState {
        case .phone:
            return RegistrationStateTitle.phone
        case .confirmationCode:
            return RegistrationStateTitle.confirmationCode
        case .email:
            return RegistrationStateTitle.email
        case .password:
            return RegistrationStateTitle.password
        case .name:
            return RegistrationStateTitle.name
        case .confirmPassword:
            return RegistrationStateTitle.confirmPassword
        }
    }
}
