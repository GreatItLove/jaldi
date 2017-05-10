//
//  JaldiPaymentDatePriceView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/10/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiPaymentDatePriceView: UIView {

    @IBOutlet weak var priceStackView: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeAndDurationLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var originalPriceCentsLabel: UILabel!
    
    func configureWith(bookingObject:BookingObject, hiddePrice:Bool) {
        let dateTime = bookingObject.bookingTime ?? Date()
        dateLabel.text = dateTime.dateStringWith(format: AppDateFormats.weekFormat)
        priceStackView.isHidden = hiddePrice
        let time  = dateTime.dateStringWith(format: AppDateFormats.timeFormat)
        timeAndDurationLabel.text = "\(time) (2 hours)"
        if let bookingPrice = bookingObject.bookingPrice {
        
            let originalPrice  = bookingPrice.originalPrice
            let originalPriceIntValue  = Int(originalPrice)
            originalPriceLabel.text = "$\(originalPriceIntValue)"
            let cents = Int((originalPrice - Float(originalPriceIntValue))*100)
            originalPriceCentsLabel.text = "$\(cents)"
            
        }
    }


}
