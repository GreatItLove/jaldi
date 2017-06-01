//
//  HomeCategory.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
enum HomeCategory: Int {
    
    case homeCleaning
    case electrician
    case painter
    case plumber
    case mason
    case carpenter
    case acTechnical
    static let allCategories = [HomeCategory.homeCleaning,
                                HomeCategory.electrician,
                                HomeCategory.painter,
                                HomeCategory.plumber,
                                HomeCategory.mason,
                                HomeCategory.carpenter,
                                HomeCategory.acTechnical
                                ]
}
struct HomeCategoryHeleper {
    struct HomeCategoryTitle {
        static let carpenter = "Carpenter"
        static let mason = "Mason"
        static let acTechnical = "Ac Technical"
        static let electrician = "Electrician"
        static let painter = "Painter"
        static let plumber = "Plumber"
        static let homeCleaning = "Home Cleaning"
        static let handyMan = "Handyman"
    }
    struct HomeCategoryDescription {
        static let carpenter = "From the ground up!"
        static let mason = "Build the future"
        static let acTechnical = "Breath of fresh air"
        static let electrician = "Don't shock yourself"
        static let painter = "Color your world"
        static let plumber = "No more leaks"
        static let homeCleaning = "Keeping it tidy"
        static let handyMan = "Fix or assemble"
    }
    struct HomeCategoryIconName {
        static let handyMane = "icon-handyman-details"
        static let electrician = "icon-electrician-details"
        static let painter = "icon-painting-details"
        static let plumber = "icon-plumbing-details"
        static let homeCleaning = "icon-home_cleaning-details"
        static let carpenter = "carpenter-icon"
        static let mason = "mason-icon"
        static let acTechnical = "ac-technical-icon"
    }
    //MARK: Helper Methods
    static  func titleFor(category:HomeCategory)->String{
        switch category {
        case .carpenter:
            return HomeCategoryTitle.carpenter
        case .homeCleaning:
            return HomeCategoryTitle.homeCleaning
        case .electrician:
            return HomeCategoryTitle.electrician
        case .mason:
            return HomeCategoryTitle.mason
        case .painter:
            return HomeCategoryTitle.painter
        case .plumber:
            return HomeCategoryTitle.plumber
        case .acTechnical:
            return HomeCategoryTitle.acTechnical
        }
    }
    
    
    static  func descriptionFor(category:HomeCategory)->String{
        switch category {
        case .carpenter:
            return HomeCategoryDescription.carpenter
        case .homeCleaning:
            return HomeCategoryDescription.homeCleaning
        case .electrician:
            return HomeCategoryDescription.electrician
        case .mason:
            return HomeCategoryDescription.mason
        case .painter:
            return HomeCategoryDescription.painter
        case .plumber:
            return HomeCategoryDescription.plumber
        case .acTechnical:
            return HomeCategoryDescription.acTechnical
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
        case .carpenter:
            return HomeCategoryIconName.carpenter
        case .mason:
            return HomeCategoryIconName.mason
        case .acTechnical:
            return HomeCategoryIconName.acTechnical
        
        }
    }
    
    static func orderTitleFor(homeCategory:HomeCategory) -> String {
        switch homeCategory {
        case .homeCleaning:
            return "HOME CLEANING"
        case .painter:
            return "HOME PAINTING"
        case .plumber:
            return "PLUMBING"
        case .mason:
            return "MASON"
        case .electrician:
            return "ELECTRICIAN"
        case .carpenter:
            return "CARPENTER"
        case .acTechnical:
            return "AC TECHNICAL"

        }
    }

}
