//
//  JaldiHomeCollectionViewCell.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiHomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryDescriptionLabel: UILabel!
    
    func configureWith(category:HomeCategory) {
        categoryTitleLabel.text = HomeCategoryHeleper.titleFor(category: category)
        categoryDescriptionLabel.text = HomeCategoryHeleper.descriptionFor(category: category)
        let iconImageName = HomeCategoryHeleper.iconImageNameFor(category: category)
        if  let icon  = UIImage(named: iconImageName) {
            categoryIcon.image = icon
        }else{
            categoryIcon.image = nil
        }
    }
}
