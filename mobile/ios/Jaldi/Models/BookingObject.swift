//
//  BookingObject.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/4/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
struct BookingObject {
    let service: JaldiService
    let bookingDetails: BookingDetails
}

struct BookingDetails {
    let title: String
    let detailItems: [BookingDetailsItem]
}

struct BookingDetailsItem {
    let title: String
    let desc: String?
    let bookingProperties:[String]
}
