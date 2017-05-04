//
//  JaldiBookingDetailsHeaderCell.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/4/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiBookingDetailsHeaderCell: UITableViewCell {
    
    @IBOutlet weak var detailsTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureWith(title:String?) {
        detailsTitleLabel.text = title
    }

}
