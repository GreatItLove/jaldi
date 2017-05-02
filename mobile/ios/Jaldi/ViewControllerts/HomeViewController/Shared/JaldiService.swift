//
//  JaldiService.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
enum JaldiService: Int {

    // Electrician
    case ceilingFan
    case electricianDefault
    case lightFixtures
    case otherElectrical
    case outlets
    // Plumber
    case garbageDisposal
    case otherPlumbing
    case plumbingDefault
    case faucetsReplacement
    case toiletTrouble
    case unclogDrains

    static let electricianServices = [JaldiService.ceilingFan,
                                JaldiService.lightFixtures,
                                JaldiService.otherElectrical,
                                JaldiService.outlets
                                ]
    static let plumberServices = [JaldiService.garbageDisposal,
                                      JaldiService.otherPlumbing,
                                      JaldiService.faucetsReplacement,
                                      JaldiService.toiletTrouble,
                                      JaldiService.unclogDrains
    ]

}
struct JaldiServiceHeleper {
    struct JaldiServiceTitle {
        static let ceilingFan = "Ceiling & Bath fans"
        static let electricianDefault = ""
        static let lightFixtures = "Lighting"
        static let otherElectrical = "Electrical Service"
        static let outlets = "Outlets & Light Swiches"
        
        static let garbageDisposal = "Garbage Disposal"
        static let otherPlumbing = "Plumbing Service"
        static let plumbingDefault = ""
        static let faucetsReplacement = "Faucets"
        static let toiletTrouble = "Toilets"
        static let unclogDrains = "Drains"
    }
    struct JaldiServiceDescription {
        static let ceilingFan = "Jaldi makes repairing or installing fans a breeze."
        static let electricianDefault = ""
        static let lightFixtures = "Does it have bulb? A trusted pro can make it shine."
        static let otherElectrical = "Electrical Service"
        static let outlets = "Outlets & Light Swiches"
        
        static let garbageDisposal = "Garbage Disposal"
        static let otherPlumbing = "Plumbing Service"
        static let plumbingDefault = ""
        static let faucetsReplacement = "We do the dirty work so you don’t have to."
        static let toiletTrouble = "Toilets"
        static let unclogDrains = "Drains"
    }
    struct JaldiServiceIconName {
        static let ceilingFan = "serviceicon-ceiling_fan"
        static let electricianDefault = "serviceicon-electrician-default"
        static let lightFixtures = "serviceicon-light_fixtures"
        static let otherElectrical = "serviceicon-other_electrical"
        static let outlets = "serviceicon-outlets"
        
        static let garbageDisposal = "serviceicon-garbage_disposal"
        static let otherPlumbing = "serviceicon-other_plumbing"
        static let plumbingDefault = "serviceicon-plumbing-default"
        static let faucetsReplacement = "serviceicon-faucets_replacement"
        static let toiletTrouble = "serviceicon-toilet_trouble"
        static let unclogDrains = "serviceicon-unclog_drains"
    }
    //MARK: Helper Methods
    static  func titleFor(service:JaldiService) -> String{
        
        switch service {
        // Electrician
        case .ceilingFan:
            return JaldiServiceTitle.ceilingFan
        case .electricianDefault:
            return JaldiServiceTitle.electricianDefault
        case .lightFixtures:
            return JaldiServiceTitle.lightFixtures
        case .otherElectrical:
            return JaldiServiceTitle.otherElectrical
        case .outlets:
            return JaldiServiceTitle.outlets
            
        // Plumber
        case .garbageDisposal:
            return JaldiServiceTitle.garbageDisposal
        case .otherPlumbing:
            return JaldiServiceTitle.otherPlumbing
        case .plumbingDefault:
            return JaldiServiceTitle.plumbingDefault
        case .faucetsReplacement:
            return JaldiServiceTitle.faucetsReplacement
        case .toiletTrouble:
            return JaldiServiceTitle.toiletTrouble
        case .unclogDrains:
            return JaldiServiceTitle.unclogDrains
        }
    }
    
    static  func descriptionFor(service:JaldiService) -> String{
        switch service {
        // Electrician
        case .ceilingFan:
            return JaldiServiceDescription.ceilingFan
        case .electricianDefault:
            return JaldiServiceDescription.electricianDefault
        case .lightFixtures:
            return JaldiServiceDescription.lightFixtures
        case .otherElectrical:
            return JaldiServiceDescription.otherElectrical
        case .outlets:
            return JaldiServiceDescription.outlets
            
        // Plumber
        case .garbageDisposal:
            return JaldiServiceDescription.garbageDisposal
        case .otherPlumbing:
            return JaldiServiceDescription.otherPlumbing
        case .plumbingDefault:
            return JaldiServiceDescription.plumbingDefault
        case .faucetsReplacement:
            return JaldiServiceDescription.faucetsReplacement
        case .toiletTrouble:
            return JaldiServiceDescription.toiletTrouble
        case .unclogDrains:
            return JaldiServiceDescription.unclogDrains
        }

    }
    
    static  func iconImageNameFor(service:JaldiService) -> String{
        switch service {
        // Electrician
        case .ceilingFan:
            return JaldiServiceIconName.ceilingFan
        case .electricianDefault:
            return JaldiServiceIconName.electricianDefault
        case .lightFixtures:
            return JaldiServiceIconName.lightFixtures
        case .otherElectrical:
            return JaldiServiceIconName.otherElectrical
        case .outlets:
            return JaldiServiceIconName.outlets
            
        // Plumber
        case .garbageDisposal:
            return JaldiServiceIconName.garbageDisposal
        case .otherPlumbing:
            return JaldiServiceIconName.otherPlumbing
        case .plumbingDefault:
            return JaldiServiceIconName.plumbingDefault
        case .faucetsReplacement:
            return JaldiServiceIconName.faucetsReplacement
        case .toiletTrouble:
            return JaldiServiceIconName.toiletTrouble
        case .unclogDrains:
            return JaldiServiceIconName.unclogDrains
        }
    }
    
    static  func servicesFor(category:HomeCategory) -> [JaldiService] {
        switch category {
        case .electrician:
            return JaldiService.electricianServices
        case .plumber:
            return JaldiService.plumberServices
        default:
            return []
        }
    }
    
    
    
}
