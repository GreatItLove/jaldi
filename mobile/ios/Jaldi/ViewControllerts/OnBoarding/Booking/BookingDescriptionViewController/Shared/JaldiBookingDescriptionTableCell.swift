//
//  JaldiBookingDescriptionTableCell.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/4/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit
protocol JaldiBookingDescriptionTableCellDelegate: class {
    func bookingDescription(cell:JaldiBookingDescriptionTableCell, didBeginEditing textView:UITextView)
    func bookingDescription(cell:JaldiBookingDescriptionTableCell, didEndEditing textView:UITextView)
}

class JaldiBookingDescriptionTableCell: UITableViewCell {

    @IBOutlet weak var descriptionTextView: UITextView!
    weak var delegate: JaldiBookingDescriptionTableCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK:Configuration
    func configureWith(bookingObject:BookingObject) {
      descriptionTextView.text = bookingObject.description
    }
}
extension JaldiBookingDescriptionTableCell:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        delegate?.bookingDescription(cell: self, didBeginEditing: textView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
      delegate?.bookingDescription(cell: self, didEndEditing: textView)
    }
}
