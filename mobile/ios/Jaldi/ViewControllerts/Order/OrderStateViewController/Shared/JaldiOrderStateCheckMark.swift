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
    func configureWith(orderState:JaldiOrderState, currentState:JaldiOrderState) {
        self.configureImageViewWith(orderState: orderState, currentState: currentState)
        self.configureStateLabelWith(orderState: orderState, currentState: currentState)
    }
    
    private func configureImageViewWith(orderState:JaldiOrderState, currentState:JaldiOrderState) {
        guard let imageName  = JaldiOrderStateHeleper.orderStateIconeFor(orderState: orderState, currentState: currentState) else {
            stateImageVew.image = nil
            return
        }
        stateImageVew.image = UIImage(named: imageName)
    }
    
    private func configureStateLabelWith(orderState:JaldiOrderState, currentState:JaldiOrderState) {
        guard let title = JaldiOrderStateHeleper.orderStateLabelTitleFor(orderState: orderState, currentState: currentState) else {
            stateLabel.isHidden = true
            return
        }
        stateLabel.isHidden = false
        stateLabel.text = title
    }
}
