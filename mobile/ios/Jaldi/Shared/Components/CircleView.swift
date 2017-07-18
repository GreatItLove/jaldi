//
//  CircleView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/29/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class CircleView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height/2;
        self.layer.masksToBounds = true
        self.clipsToBounds = true;
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 3;
        
    }
}
