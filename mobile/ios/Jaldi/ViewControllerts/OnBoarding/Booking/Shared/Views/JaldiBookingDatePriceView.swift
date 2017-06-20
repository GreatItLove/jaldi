//
//  JaldiBookingDatePriceView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/5/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiBookingDatePriceView: UIView {

   @IBOutlet weak var dateLabel: UILabel!
   @IBOutlet weak var timeAndDurationLabel: UILabel!
   @IBOutlet weak var originalPriceLabel: UILabel!
   @IBOutlet weak var priceLabel: UILabel!
   @IBOutlet weak var originalPriceCentsLabel: UILabel!
   
    func configureWith(bookingObject:BookingObject) {
        let dateTime = bookingObject.bookingTime ?? Date()
        dateLabel.text = dateTime.dateStringWith(format: AppDateFormats.weekFormat)
        
        let time  = dateTime.dateStringWith(format: AppDateFormats.timeFormat)
        timeAndDurationLabel.text = "\(time) (2 hours)"
        if let bookingPrice = bookingObject.bookingPrice {
            if bookingPrice.coupon == 0 {
                priceLabel.isHidden = true
            }else{
            priceLabel.isHidden = false
                priceLabel.text = "$\(Int((bookingPrice.price)))"
            }
            let originalPrice  = bookingPrice.originalPrice
            let originalPriceIntValue  = Int(originalPrice)
            originalPriceLabel.text = "$\(originalPriceIntValue)"
            let cents = Int((originalPrice - Float(originalPriceIntValue))*100)
            originalPriceCentsLabel.text = "$\(cents)"
          
        }
    }
}

//class UnderlinedLabel: UILabel {
//    
//    override var text: String? {
//        didSet {
//            guard let text = text else { return }
//            let textRange = NSMakeRange(0, text.characters.count)
//            let attributedText = NSMutableAttributedString(string: text)
//            attributedText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
//            // Add other attributes if needed
//            self.attributedText = attributedText
//        }
//    }
//}
