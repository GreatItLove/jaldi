//
//  JaldiBookingPaymentTermOfUseCell.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/10/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit
protocol JaldiBookingPaymentTermOfUseCellDelegate: class {
    func termOfUseDidSelect(cell: JaldiBookingPaymentTermOfUseCell)
}
class JaldiBookingPaymentTermOfUseCell: UITableViewCell {

    weak var delegate: JaldiBookingPaymentTermOfUseCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func termOfUseAction(_ sender: Any) {
        delegate?.termOfUseDidSelect(cell: self)
    }

}
