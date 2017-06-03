//
//  JaldiPaymentPriceDetailsView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/10/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit


class JaldiPaymentPriceDetailsView: UIView {
    @IBOutlet weak var detailsTitleLabel: UILabel!
    @IBOutlet weak var detailsValueLabel: UILabel!

    //Mark: Configuration
    func configureWith(bookingPrice:BookingPrice,bookingDetails:BookingDetails) {
        
        self.configureTitleLabelFor(bookingDetails:bookingDetails)
        self.configureValueLabelFor(bookingPrice: bookingPrice, bookingDetails: bookingDetails)
    }

    private func configureTitleLabelFor(bookingDetails:BookingDetails ) {
        detailsTitleLabel.text = "Cleaning (\(bookingDetails.hours) hours)"
    }
    
    private func configureValueLabelFor(bookingPrice:BookingPrice , bookingDetails:BookingDetails ) {
        detailsValueLabel.text = "\(bookingDetails.hours)x\(bookingPrice.serivcePrice) QAR"
    }
 
}
