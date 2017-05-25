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
    var bookingTime: Date?
    let bookingScreens: [BookingScreen]
    var contactInfo: BookingContactInfo?
    var bookingPrice: BookingPrice?
    var cardInfo: CardInfo?
    
    init(service:JaldiService, bookingDetails:BookingDetails,bookingScreens:[BookingScreen]) {
        self.service = service
        self.bookingDetails = bookingDetails
        self.bookingScreens = bookingScreens
        bookingPrice = BookingPrice()
        bookingPrice?.serivcePrice = 87
        bookingPrice?.fee = 3
        bookingPrice?.coupon = 43.5
    }
}

class BookingDetails {
    let title: String
    let detailItems: [BookingDetailsItem]
    let hoursSugestationEnabled: Bool
    init(title:String, detailItems:[BookingDetailsItem],hoursSugestationEnabled:Bool = false) {
        self.title = title
        self.detailItems = detailItems
        self.hoursSugestationEnabled = hoursSugestationEnabled
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

class BookingContactInfo {
    var fullName: String?
    var streetAddress: String?
    var apt: String?
    var phone: String?
}
class BookingPrice {
    var price: Float {
        get {
            return serivcePrice + fee
        }
    }
    var serivcePrice: Float = 0
    var coupon: Float = 0
    var fee: Float = 0
    
    var originalPrice: Float {
        get {
            return serivcePrice - coupon + fee
        }
    }
}

class CardInfo {
    var cardNumber: String?
    var cardDate: String?
    var cvc: String?
    var promoCode: String?
}
enum BookingScreen: Int {
    // handyMan
    case details
    case desc
    case time
    case contactInfo
    case payment
}
