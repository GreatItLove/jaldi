//
//  BookingHelper.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/4/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
struct BookingHelper {
   
    static func bookingObjectFor(service:JaldiService) -> BookingObject {
        let bookingDetails = BookingDetailsHelper.bookingDetailsFor(service: service)
        return BookingObject(service: service, bookingDetails: bookingDetails)
    }
    //MARK: BookingDetailsHelper Helper
    struct BookingDetailsHelper {
        static func bookingDetailsFor(service:JaldiService) -> BookingDetails {
            let helper = BookingDetailsHelper()
            let title = helper.bookingDetailsTitleFor(service: service)
            let items = helper.bookingDetailsItmesFor(service: service)
            return BookingDetails(title: title, detailItems: items)
        }
        
        private func bookingDetailsTitleFor(service:JaldiService) -> String {
            return "Got it! Tell us about the job"
        }
        private func bookingDetailsItmesFor(service:JaldiService) -> [BookingDetailsItem] {
            return [BookingDetailsItem]()
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
            default:
               return helper.bookingDetailsDefaultItems()
            }
        }
        
        private func bookingDetailsDefaultItems() -> [BookingDetailsItem]  {
          let hours  =  (0...10).map { "\($0)" }
          return [BookingDetailsItem(title: "Hours", desc: nil, bookingProperties: hours)]
        }
        //MARK: Items for Service
        private func lightFixturesItems() -> [BookingDetailsItem] {
            let changeBulbsTitle  = "Change bulbs"
            let changeBulbsProperties  = (0...10).map { "\($0)" }
            let changeBulbs = BookingDetailsItem(title: changeBulbsTitle, desc: nil, bookingProperties: changeBulbsProperties)
            
            let installNewLightTitle  = "Change bulbs"
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
    }
    
   
}
