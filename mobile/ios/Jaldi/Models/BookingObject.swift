//
//  BookingObject.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/4/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
class BookingObject {
    let service: JaldiService
    let bookingDetails: BookingDetails
    var description: String?
    init(service:JaldiService, bookingDetails:BookingDetails) {
        self.service = service
        self.bookingDetails = bookingDetails
    }
}

class BookingDetails {
    let title: String
    let detailItems: [BookingDetailsItem]
    init(title:String, detailItems:[BookingDetailsItem]) {
        self.title = title
        self.detailItems = detailItems
    }
}

class BookingDetailsItem {
    let title: String
    let desc: String?
    let bookingProperties:[String]
    var sellectedIndex: Int = 0
    init(title:String, desc:String?, bookingProperties:[String], sellectedIndex: Int = 0) {
        self.title = title
        self.desc = desc
        self.bookingProperties = bookingProperties
        self.sellectedIndex = sellectedIndex
    }
    
    func canShowDescription() -> Bool {
        guard let _ = self.desc else {
            return false
        }
        return self.bookingProperties[self.sellectedIndex] !=  BookingHelper.BookingDetailsItemHelper.noTitle
    }
 }
