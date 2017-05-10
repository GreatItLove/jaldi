//
//  JaldiPaymentPriceDetailsView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/10/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

enum PaymentPriceField: Int {
    case price
    case coupon
    case fee
}
class JaldiPaymentPriceDetailsView: UIView {

    private struct PriceDetailTitle {
        static let price = "Home Cleaning"
        static let coupon = "Coupon"
        static let fee = "Trust and Support Fee"
    }
    @IBOutlet weak var infoButtoon: UIButton!
    @IBOutlet weak var detailsTitleLabel: UILabel!
    @IBOutlet weak var detailsValueLabel: UILabel!
    private var paymentPriceField:PaymentPriceField = PaymentPriceField.price

    //Mark: Configuration
    func configureWith(bookingPrice:BookingPrice , priceField:PaymentPriceField ) {
        self.paymentPriceField = priceField
        self.configureInfoButtonStateFor(priceField: priceField)
        self.configureTitleLabelFor(priceField: priceField)
        self.configureValueLabelFor(bookingPrice: bookingPrice, priceField: priceField)
    }
    
    private func configureInfoButtonStateFor(priceField:PaymentPriceField ) {
        let infoButtonIsHidden = priceField != .fee
        self.infoButtoon.isHidden = infoButtonIsHidden
    }
    
    private func configureTitleLabelFor(priceField:PaymentPriceField ) {
        switch priceField {
        case .price:
            detailsTitleLabel.text = PriceDetailTitle.price
        case .coupon:
            detailsTitleLabel.text = PriceDetailTitle.coupon
        case .fee:
            detailsTitleLabel.text = PriceDetailTitle.fee
        }
    }
    
    private func configureValueLabelFor(bookingPrice:BookingPrice , priceField:PaymentPriceField ) {
        switch priceField {
        case .price:
            detailsValueLabel.text = "$\(bookingPrice.serivcePrice)"
        case .coupon:
            detailsValueLabel.text = "-$\(bookingPrice.coupon)"
        case .fee:
            detailsValueLabel.text = "$\(bookingPrice.fee)"
        }
    }
    
    //MARK: Actions
    @IBAction func infoAction(_ sender: Any) {
       print(infoAction)
    }
 
}
