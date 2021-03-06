//
//  JaldiPaymentDatePriceView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/10/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiPaymentDatePriceView: UIView {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeAndDurationLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    
    func configureWith(bookingObject:BookingObject, hiddePrice:Bool) {
        let dateTime = bookingObject.bookingTime ?? Date()
        dateLabel.text = dateTime.dateStringWith(format: AppDateFormats.weekFormat)
        originalPriceLabel.isHidden = hiddePrice
        let time  = dateTime.dateStringWith(format: AppDateFormats.timeFormat)
        let workers = bookingObject.bookingDetails.workers > 1 ? "\(bookingObject.bookingDetails.workers) workers" : ""
        timeAndDurationLabel.text = "\(time) (\(bookingObject.bookingDetails.hours) hours, \(workers))"
        originalPriceLabel.text = "\(Int(bookingObject.cost)) QR"
    }


}
