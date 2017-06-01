//
//  JaldiOrderStateCheckMark.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/29/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOrderStateCheckMark: UIView {
    @IBOutlet weak var stateImageVew: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    func configureWith(orderState:JaldiOrderState, isSelected:Bool) {
        self.configureImageViewWith(orderState: orderState, isSelected: isSelected)
        self.configureStateLabelWith(orderState: orderState, isSelected: isSelected)
    }
    
    private func configureImageViewWith(orderState:JaldiOrderState, isSelected:Bool) {
        guard let imageName  = JaldiOrderStateHeleper.orderStateIconeFor(orderState: orderState, selected: isSelected) else {
            stateImageVew.image = nil
            return
        }
        stateImageVew.image = UIImage(named: imageName)
    }
    
    private func configureStateLabelWith(orderState:JaldiOrderState, isSelected:Bool) {
        guard let title = JaldiOrderStateHeleper.orderStateLabelTitleFor(orderState: orderState, selected: isSelected) else {
            stateLabel.isHidden = true
            return
        }
        stateLabel.isHidden = false
        stateLabel.text = title
    }
}
