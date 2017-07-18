//
//  JaldiOnBoradingListViewHeaderCell.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOnBoradingListViewHeaderCell: UITableViewCell {

    @IBOutlet weak var onBoardingTitleLabel: UILabel!
    @IBOutlet weak var onBoardingIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: Configuration
    func configureWith(category:HomeCategory) {
        onBoardingTitleLabel.text = HomeCategoryHeleper.titleFor(category: category)
        let iconImageName = HomeCategoryHeleper.iconImageNameFor(category: category)
        if  let icon  = UIImage(named: iconImageName) {
            onBoardingIcon.image = icon
        }else{
            onBoardingIcon.image = nil
        }
    }

}
