//
//  JaldiOnBoradingListViewCell.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOnBoradingListViewCell: UITableViewCell {

    @IBOutlet weak var serviceTitleLabel: UILabel!
    @IBOutlet weak var serviceDescriptionLabel: UILabel!
    @IBOutlet weak var serviceIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureWith(service:JaldiService) {
        serviceTitleLabel.text = JaldiServiceHeleper.titleFor(service: service)
        serviceDescriptionLabel.text = JaldiServiceHeleper.descriptionFor(service: service)
        let iconImageName = JaldiServiceHeleper.iconImageNameFor(service: service)
        if  let icon  = UIImage(named: iconImageName) {
            serviceIcon.image = icon
        }else{
            serviceIcon.image = nil
        }
    }

}
