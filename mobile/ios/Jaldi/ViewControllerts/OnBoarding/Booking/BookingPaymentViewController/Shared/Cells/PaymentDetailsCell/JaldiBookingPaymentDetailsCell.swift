//
//  JaldiBookingPaymentDetailsCell.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/10/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit
protocol JaldiBookingPaymentDetailsCellDelegate: class {
//    func paymentDetails(cell: JaldiBookingPaymentDetailsCell, didBeginEditing textField: UITextField, cardInfoField: CardInfoField)
    func paymentDetails(didShowPaymentDetailsFor cell: JaldiBookingPaymentDetailsCell)
}

class JaldiBookingPaymentDetailsCell: UITableViewCell {

    @IBOutlet weak var peyamentDetailsActionableView: UIView!
    @IBOutlet weak var peyamentDetailsStackView: UIStackView!
    
    @IBOutlet weak var peyamentDetailsPriceView: JaldiPaymentPriceDetailsView!
    @IBOutlet weak var peyamentDetailsCouponView: JaldiPaymentPriceDetailsView!
    @IBOutlet weak var peyamentDetailsFeeView: JaldiPaymentPriceDetailsView!
    
    @IBOutlet weak var paymentDatePriceView: JaldiPaymentDatePriceView!
    @IBOutlet weak var totalPriceView: JaldiPaymentTotalPriceView!
    
    
    weak var delegate: JaldiBookingPaymentDetailsCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:Configuration
    func configureWith(bookingObject:BookingObject , showPaymentDetails:Bool) {
        self.paymentDatePriceView.configureWith(bookingObject: bookingObject, hiddePrice: showPaymentDetails)
        peyamentDetailsActionableView.isHidden = showPaymentDetails
        peyamentDetailsStackView.isHidden = !showPaymentDetails
        self.configurePaymentDetailsFor(bookingObject: bookingObject)
        self.totalPriceView.configureWith(bookingObject: bookingObject)
    }
    
    private func configurePaymentDetailsFor(bookingObject:BookingObject) {
        guard let bookingPrice = bookingObject.bookingPrice else {
            peyamentDetailsPriceView.isHidden = true
            peyamentDetailsCouponView.isHidden = true
            peyamentDetailsFeeView.isHidden = true
            return
        }
        peyamentDetailsPriceView.configureWith(bookingPrice: bookingPrice, priceField: .price)
        peyamentDetailsCouponView.configureWith(bookingPrice: bookingPrice, priceField: .coupon)
        peyamentDetailsFeeView.configureWith(bookingPrice: bookingPrice, priceField: .fee)
    }
    //MARK: Actions
    @IBAction func showPaymentDetailsAction(_ sender: Any) {
        delegate?.paymentDetails(didShowPaymentDetailsFor: self)
    }

}
