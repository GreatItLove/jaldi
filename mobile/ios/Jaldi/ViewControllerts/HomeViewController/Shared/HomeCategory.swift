//
//  HomeCategory.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
enum HomeCategory: Int {
    case carpenter
    case electrician
    case mason
    case painter
    case plumber
    case acTechnical
    static let allCategories = [HomeCategory.carpenter,
                                HomeCategory.electrician,
                                HomeCategory.mason,
                                HomeCategory.painter,
                                HomeCategory.plumber,
                                HomeCategory.acTechnical,
                                ]
}
struct HomeCategoryHeleper {
    struct HomeCategoryTitle {
        static let carpenter = "Carpenter"
        static let electrician = "Electrician"
        static let mason = "Mason"
        static let painter = "Painter"
        static let plumber = "Plumber"
        static let acTechnical = "Ac Technical"
    }
    struct HomeCategoryDescription {
        static let carpenter = "Carpenter"
        static let electrician = "Don't shock yourself"
        static let mason = "Mason"
        static let painter = "Color you world"
        static let plumber = "No more leaks"
        static let acTechnical = "Ac Technical"
    }
    struct HomeCategoryIconName {
        static let handyMane = "icon-handyman-details"
        static let electrician = "icon-electrician-details"
        static let painter = "icon-painting-details"
        static let plumber = "icon-plumbing-details"
    }
    //MARK: Helper Methods
    static  func titleFor(category:HomeCategory)->String{
        switch category {
        case .carpenter:
            return HomeCategoryTitle.carpenter
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
        default:
            return HomeCategoryIconName.handyMane
        }
    }


}
