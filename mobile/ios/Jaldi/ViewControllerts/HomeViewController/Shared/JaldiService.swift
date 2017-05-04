//
//  JaldiService.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
enum JaldiService: Int {

    // Parent Services
    case homeCleaning
  
    // handyMan
    case acRepair
    case furnitureAssembly
    case handymanDefault
    case hangingPicturesShelves
    case installWindowTreatments
    case mountTv
    case movingHelp
    case installKnobsLocks
    case otherHandymanService

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
    static let handyManServices = [JaldiService.hangingPicturesShelves,
                                      JaldiService.acRepair,
                                      JaldiService.furnitureAssembly,
                                      JaldiService.movingHelp,
                                      JaldiService.mountTv,
                                      JaldiService.installWindowTreatments,
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
        
        static let acRepair = "Air Conditioning"
        static let furnitureAssembly = "Furniture Assembly"
        static let handymanDefault = "serviceicon-handyman-default"
        static let hangingPicturesShelves = "Hanging Items"
        static let installWindowTreatments = "Window Treatments"
        static let mountTv = "TV Mounting"
        static let movingHelp = "Moving Help"
        static let installKnobsLocks = "Install Knobs Locks"
        static let otherHandymanService = "Other Handyman"
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
        
        static let acRepair = "Air Conditioning"
        static let furnitureAssembly = "Furniture Assembly"
        static let handymanDefault = "serviceicon-handyman-default"
        static let hangingPicturesShelves = "Hanging Items"
        static let installWindowTreatments = "Window Treatments"
        static let mountTv = "TV Mounting"
        static let movingHelp = "Moving Help"
        static let installKnobsLocks = "Install Knobs Locks"
        static let otherHandymanService = "Other Handyman"
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
        
        static let acRepair = "serviceicon-ac_repair"
        static let furnitureAssembly = "serviceicon-furniture_assembly"
        static let handymanDefault = "serviceicon-handyman-default"
        static let hangingPicturesShelves = "serviceicon-hanging_pictures_shelves"
        static let installWindowTreatments = "serviceicon-install_window_treatments"
        static let mountTv = "serviceicon-mount_tv"
        static let movingHelp = "serviceicon-moving_help"
        static let installKnobsLocks = "serviceicon-install_knobs_locks"
        static let otherHandymanService = "serviceicon-other_handyman_service"
        
    }
    //MARK: Helper Methods
    static  func titleFor(service:JaldiService) -> String{
        switch service {
        // HandyMan
        case .acRepair:
            return JaldiServiceTitle.acRepair
        case .furnitureAssembly:
            return JaldiServiceTitle.furnitureAssembly
        case .handymanDefault:
            return JaldiServiceTitle.handymanDefault
        case .hangingPicturesShelves:
            return JaldiServiceTitle.hangingPicturesShelves
        case .installWindowTreatments:
            return JaldiServiceTitle.installWindowTreatments
        case .mountTv:
            return JaldiServiceTitle.mountTv
        case .movingHelp:
            return JaldiServiceTitle.movingHelp
        case .installKnobsLocks:
            return JaldiServiceTitle.installKnobsLocks
        case .otherHandymanService:
            return JaldiServiceTitle.otherHandymanService

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
        default:
            return ""
        }
    }
    
    static  func descriptionFor(service:JaldiService) -> String{
        switch service {
        // HandyMan
        case .acRepair:
            return JaldiServiceDescription.acRepair
        case .furnitureAssembly:
            return JaldiServiceDescription.furnitureAssembly
        case .handymanDefault:
            return JaldiServiceDescription.handymanDefault
        case .hangingPicturesShelves:
            return JaldiServiceDescription.hangingPicturesShelves
        case .installWindowTreatments:
            return JaldiServiceDescription.installWindowTreatments
        case .mountTv:
            return JaldiServiceDescription.mountTv
        case .movingHelp:
            return JaldiServiceDescription.movingHelp
        case .installKnobsLocks:
            return JaldiServiceDescription.installKnobsLocks
        case .otherHandymanService:
            return JaldiServiceDescription.otherHandymanService
            
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
        default:
            return ""
        }

    }
    
    static  func iconImageNameFor(service:JaldiService) -> String{
        switch service {
        // HandyMan
        case .acRepair:
            return JaldiServiceIconName.acRepair
        case .furnitureAssembly:
            return JaldiServiceIconName.furnitureAssembly
        case .handymanDefault:
            return JaldiServiceIconName.handymanDefault
        case .hangingPicturesShelves:
            return JaldiServiceIconName.hangingPicturesShelves
        case .installWindowTreatments:
            return JaldiServiceIconName.installWindowTreatments
        case .mountTv:
            return JaldiServiceIconName.mountTv
        case .movingHelp:
            return JaldiServiceIconName.movingHelp
        case .installKnobsLocks:
            return JaldiServiceIconName.installKnobsLocks
        case .otherHandymanService:
            return JaldiServiceIconName.otherHandymanService
            
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
        default:
            return JaldiServiceIconName.plumbingDefault
        }
    }
    
    static  func servicesFor(category:HomeCategory) -> [JaldiService] {
        switch category {
        case .electrician:
            return JaldiService.electricianServices
        case .plumber:
            return JaldiService.plumberServices
        case .handyMan:
            return JaldiService.handyManServices
        default:
            return []
        }
    }
    static  func serviceFor(category:HomeCategory) -> JaldiService?{
        switch category {
        case .homeCleaning:
            return JaldiService.homeCleaning
        default:
            return nil
        }
    }
    
   
    
}
