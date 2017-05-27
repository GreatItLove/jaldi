//
//  BookingHelper.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/4/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
struct BookingHelper {
   
    static let defaultTitle = "Got it! Tell us about the job"
    static let timeDefaultTitle = "When would you like us to come?"
    static func bookingObjectFor(service:JaldiService) -> BookingObject {
        let bookingDetails = BookingDetailsHelper.bookingDetailsFor(service: service)
//        return BookingObject(service: service, bookingDetails: bookingDetails, bookingScreens: [BookingScreen.details,BookingScreen.payment])

        return BookingObject(service: service, bookingDetails: bookingDetails, bookingScreens: [BookingScreen.details,BookingScreen.time,BookingScreen.desc,BookingScreen.payment])
    }
    //MARK: BookingDetailsHelper Helper
    struct BookingDetailsHelper {
        static func bookingDetailsFor(service:JaldiService) -> BookingDetails {
            let helper = BookingDetailsHelper()
            let title = helper.bookingDetailsTitleFor(service: service)
            let items = helper.bookingDetailsItmesFor(service: service)
            let hoursSuggestionEnabled = service == .homeCleaning
            return BookingDetails(title: title, detailItems: items, hoursSuggestionEnabled:hoursSuggestionEnabled)
        }
        
        private func bookingDetailsTitleFor(service:JaldiService) -> String {
            switch service {
            case .homeCleaning:
                return "Tell us about your place"
            default:
                return BookingHelper.defaultTitle
            }
            
        }
        private func bookingDetailsItmesFor(service:JaldiService) -> [BookingDetailsItem] {
            return BookingDetailsItemHelper.bookingItemsFor(service:service)
        }
    }
    
    //MARK: BookingDetailsHelper Helper
    struct BookingDetailsItemHelper {
        static let noTitle = "No"
        static func bookingItemsFor(service:JaldiService) -> [BookingDetailsItem] {
            let helper = BookingDetailsItemHelper()
            switch service {
            case .lightFixtures:
                return helper.lightFixturesItems()
            case .homeCleaning:
                return helper.homeCleaningItems()
            default:
               return helper.bookingDetailsDefaultItems()
            }
        }
        
        private func bookingDetailsDefaultItems() -> [BookingDetailsItem]  {
            
            let hoursTitle  = "Hours"
            let hoursProperties   =  (2...10).map { "\($0)" }
            let hours = BookingDetailsItem(title: hoursTitle, desc: nil, bookingProperties: hoursProperties)
            
            let professionalsTitle  = "Professionals"
            let professionalsProperties   =  (1...10).map { "\($0)" }
            let professionals = BookingDetailsItem(title: professionalsTitle, desc: nil, bookingProperties: professionalsProperties)
            
            return [hours,professionals]
        }
       
        //MARK: Items for Service
        private func lightFixturesItems() -> [BookingDetailsItem] {
            let changeBulbsTitle  = "Change bulbs"
            let changeBulbsProperties  = (0...10).map { "\($0)" }
            let changeBulbs = BookingDetailsItem(title: changeBulbsTitle, desc: nil, bookingProperties: changeBulbsProperties)
            
            let installNewLightTitle  = "Install new lights"
            let installNewLightProperties  = (0...10).map { "\($0)" }
            let installNewLight = BookingDetailsItem(title: installNewLightTitle, desc: nil, bookingProperties: installNewLightProperties)
            
            let laaderTitle  = "Will a Ladder be required?"
            let laaderProperties  = [BookingDetailsItemHelper.noTitle,"Yes - 6 ft (1.8 m)","Yes - 10 ft (3 m)"]
            let laaderDesc  = "There will be an additional fee"
            let laader = BookingDetailsItem(title: laaderTitle, desc: laaderDesc, bookingProperties: laaderProperties)
            
            let fixturesTitle  = "Do you need us to provide the fixtures?"
            let fixturesProperties  = [BookingDetailsItemHelper.noTitle,"Yes - 6 ft (1.8 m)","Yes - 10 ft (3 m)"]
            let fixturesDesc  = "If so , your professional will connect you to determine what items to purchase. A receipt will be presented and the cost added to your booking cost."
            let fixtures = BookingDetailsItem(title: fixturesTitle, desc: fixturesDesc, bookingProperties: fixturesProperties)
            
            return [changeBulbs,installNewLight,laader,fixtures]
        }
        
        private func homeCleaningItems() -> [BookingDetailsItem] {
            let bedroomsTitle  = "Bedrooms"
            let bedroomsProperties  = (0...10).map { "\($0)" }
            let bedrooms = BookingDetailsItem(title: bedroomsTitle, desc: nil, bookingProperties: bedroomsProperties,sellectedIndex:1)
            
            let bathroomsTitle  = "Bathrooms"
            let bathroomsProperties  = (0...10).map { "\($0)" }
            let bathrooms = BookingDetailsItem(title: bathroomsTitle, desc: nil, bookingProperties: bathroomsProperties,sellectedIndex:1)
        
            return [bedrooms,bathrooms]
        }
    }
    
   
}
