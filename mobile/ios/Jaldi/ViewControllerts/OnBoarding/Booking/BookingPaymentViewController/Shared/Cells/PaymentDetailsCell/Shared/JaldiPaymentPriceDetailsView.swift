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
    func configureWith(bookingPrice:BookingPrice,bookingDetails:BookingDetails, category:HomeCategory) {
        
        self.configureTitleLabelFor(bookingDetails:bookingDetails, category: category)
        self.configureValueLabelFor(bookingPrice: bookingPrice, bookingDetails: bookingDetails)
    }

    private func configureTitleLabelFor(bookingDetails:BookingDetails, category:HomeCategory) {
        let title = HomeCategoryHeleper.orderTitleFor(homeCategory:category)
        let workers = bookingDetails.workers > 1 ? ", \(bookingDetails.workers) workers" : ""
        detailsTitleLabel.text = "\(title) (\(bookingDetails.hours) hours\(workers))"
    }
    
    private func configureValueLabelFor(bookingPrice:BookingPrice , bookingDetails:BookingDetails ) {
        detailsValueLabel.text = "\(bookingDetails.hours*bookingDetails.workers)x\(bookingPrice.serivcePrice) QAR"
    }
 
}
