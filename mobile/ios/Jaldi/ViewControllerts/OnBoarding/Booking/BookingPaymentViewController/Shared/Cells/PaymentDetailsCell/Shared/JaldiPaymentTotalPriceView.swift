//
//  JaldiPaymentTotalPriceView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/10/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiPaymentTotalPriceView: UIView {

    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var originalPriceCentsLabel: UILabel!
    
    func configureWith(bookingObject:BookingObject) {
        
        if let bookingPrice = bookingObject.bookingPrice {
            let originalPrice  = bookingPrice.originalPrice
            let originalPriceIntValue  = Int(originalPrice)
            originalPriceLabel.text = "$\(originalPriceIntValue)"
            let cents = Int((originalPrice - Float(originalPriceIntValue))*100)
            originalPriceCentsLabel.text = "$\(cents)"
            print("Total price \(self.frame.size)")
        }
    }

}
