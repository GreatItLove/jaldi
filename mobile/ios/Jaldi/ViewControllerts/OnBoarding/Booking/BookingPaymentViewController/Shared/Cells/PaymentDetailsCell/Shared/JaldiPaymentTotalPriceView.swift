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
    
    func configureWith(bookingObject:BookingObject) {
         originalPriceLabel.text = "\(Int(bookingObject.cost)) QR"
    }
}
