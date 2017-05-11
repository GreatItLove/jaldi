//
//  HomeCategory.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
enum HomeCategory: Int {
//    case carpenter
    case homeCleaning
    case handyMan
    case electrician
//    case mason
    case painter
    case plumber
//    case acTechnical
    static let allCategories = [HomeCategory.homeCleaning,
                                HomeCategory.handyMan,
                                HomeCategory.electrician,
                                HomeCategory.painter,
                                HomeCategory.plumber,
                                ]
}
struct HomeCategoryHeleper {
    struct HomeCategoryTitle {
//        static let carpenter = "Carpenter"
//        static let mason = "Mason"
//        static let acTechnical = "Ac Technical"
        static let electrician = "Electrician"
        static let painter = "Painter"
        static let plumber = "Plumber"
        static let homeCleaning = "Home Cleaning"
        static let handyMan = "Handyman"
    }
    struct HomeCategoryDescription {
//        static let carpenter = "Carpenter"
//        static let mason = "Mason"
//        static let acTechnical = "Ac Technical"
        static let electrician = "Don't shock yourself"
        static let painter = "Color your world"
        static let plumber = "No more leaks"
        static let homeCleaning = "Keeping it tify"
        static let handyMan = "Fix or assemble"
    }
    struct HomeCategoryIconName {
        static let handyMane = "icon-handyman-details"
        static let electrician = "icon-electrician-details"
        static let painter = "icon-painting-details"
        static let plumber = "icon-plumbing-details"
        static let homeCleaning = "icon-home_cleaning-details"
    }
    //MARK: Helper Methods
    static  func titleFor(category:HomeCategory)->String{
        switch category {
//        case .carpenter:
//            return HomeCategoryTitle.carpenter
        case .homeCleaning:
            return HomeCategoryTitle.homeCleaning
        case .electrician:
            return HomeCategoryTitle.electrician
//        case .mason:
//            return HomeCategoryTitle.mason
        case .painter:
            return HomeCategoryTitle.painter
        case .plumber:
            return HomeCategoryTitle.plumber
        case .handyMan:
            return HomeCategoryTitle.handyMan
//        case .acTechnical:
//            return HomeCategoryTitle.acTechnical
        }
    }
    
    static  func descriptionFor(category:HomeCategory)->String{
        switch category {
//        case .carpenter:
//            return HomeCategoryDescription.carpenter
        case .homeCleaning:
            return HomeCategoryDescription.homeCleaning
        case .electrician:
            return HomeCategoryDescription.electrician
//        case .mason:
//            return HomeCategoryDescription.mason
        case .painter:
            return HomeCategoryDescription.painter
        case .plumber:
            return HomeCategoryDescription.plumber
        case .handyMan:
            return HomeCategoryDescription.handyMan
//        case .acTechnical:
//            return HomeCategoryDescription.acTechnical
        }
    }
    
    static  func iconImageNameFor(category:HomeCategory)->String{
        switch category {
        case .electrician:
            return HomeCategoryIconName.electrician
        case .painter:
            return HomeCategoryIconName.painter
        case .plumber:
            return HomeCategoryIconName.plumber
        case .homeCleaning:
            return HomeCategoryIconName.homeCleaning
        case .handyMan:
            return HomeCategoryIconName.handyMane
        
        }
    }
   
}
