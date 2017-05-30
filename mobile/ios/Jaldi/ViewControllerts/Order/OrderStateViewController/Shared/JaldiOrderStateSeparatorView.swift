//
//  JaldiOrderStateSeparatorView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/25/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOrderStateSeparatorView: UIView {

    func configureState(selected:Bool) {
        self.backgroundColor =  selected ? AppColors.GreenColor : AppColors.GrayColor
    }
}
