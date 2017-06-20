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

    @IBOutlet weak var paymentDetailsTitle: UILabel!
    @IBOutlet weak var peyamentDetailsActionableView: UIView!
    @IBOutlet weak var peyamentDetailsStackView: UIStackView!
    
    @IBOutlet weak var peyamentDetailsPriceView: JaldiPaymentPriceDetailsView!
    @IBOutlet weak var couponeView: JaldiPaymentPriceDetailsView!
    
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
        let homeCategory = JaldiServiceHeleper.homeCategoryFor(service: bookingObject.service)
        self.paymentDetailsTitle.text = HomeCategoryHeleper.orderTitleFor(homeCategory:homeCategory)
        self.configurePaymentDetailsFor(bookingObject: bookingObject)
        self.totalPriceView.isHidden = !showPaymentDetails
        self.totalPriceView.configureWith(bookingObject: bookingObject)
    }
    
    private func configurePaymentDetailsFor(bookingObject:BookingObject) {
        guard let bookingPrice = bookingObject.bookingPrice else {
            peyamentDetailsPriceView.isHidden = true
            return
        }
        let homeCategory = JaldiServiceHeleper.homeCategoryFor(service: bookingObject.service)
        peyamentDetailsPriceView.configureWith(bookingPrice: bookingPrice, bookingDetails: bookingObject.bookingDetails, category: homeCategory)
    }
    //MARK: Actions
    @IBAction func showPaymentDetailsAction(_ sender: Any) {
        delegate?.paymentDetails(didShowPaymentDetailsFor: self)
    }

}
