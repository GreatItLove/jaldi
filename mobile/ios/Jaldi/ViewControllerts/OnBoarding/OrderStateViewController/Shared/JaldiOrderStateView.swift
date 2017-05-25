//
//  JaldiOrderStateView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/25/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOrderStateView: UIView {
    @IBOutlet weak var enRouteImageVew: UIImageView!
    @IBOutlet weak var workingImageVew: UIImageView!
    @IBOutlet weak var tidyingUpImageVew: UIImageView!
    @IBOutlet weak var finishedImageVew: UIImageView!
    
    @IBOutlet weak var enRouteLabel: UILabel!
    @IBOutlet weak var workingLabel: UILabel!
    @IBOutlet weak var tidyingLabel: UILabel!
    @IBOutlet weak var finishedLabel: UILabel!

    
    @IBOutlet weak var workingSeparator: JaldiOrderStateSeparatorView!
    @IBOutlet weak var tidyingUpSeparator: JaldiOrderStateSeparatorView!
    @IBOutlet weak var finishedSeparator: JaldiOrderStateSeparatorView!
    
    func configureWith(orderState:JaldiOrderState) {
        self.configureStateLabels()
        self.configureIconsFor(orderState: orderState)
        self.configureSeparatorsFor(orderState: orderState)
    }
    
    private func configureIconsFor(orderState:JaldiOrderState) {
        for state in JaldiOrderState.allStates {
            let imageView = self.imageViewForState(orderState: state)
            let isSelected = state.rawValue <= orderState.rawValue
            let imageName  = JaldiOrderStateHeleper.orderStateIconeFor(orderState: state, selected: isSelected)
            imageView.image = UIImage(named: imageName)
        }
    }
    
    private func configureStateLabels() {
        enRouteLabel.text = JaldiOrderStateHeleper.orderStateTitleFor(orderState: .enRoute)
        workingLabel.text = JaldiOrderStateHeleper.orderStateTitleFor(orderState: .working)
        tidyingLabel.text = JaldiOrderStateHeleper.orderStateTitleFor(orderState: .tidyingUp)
        finishedLabel.text = JaldiOrderStateHeleper.orderStateTitleFor(orderState: .finished)
    }
    
    private func configureSeparatorsFor(orderState:JaldiOrderState) {
        for state in JaldiOrderState.allStates {
            if let separator = self.separatorFor(orderState: state){
                let isSelected = state.rawValue <= orderState.rawValue
                separator.configureState(selected: isSelected)
            }
        }
    }
   
    //Mark: Helpers
    private func imageViewForState(orderState:JaldiOrderState) -> UIImageView {
        switch orderState {
        case .enRoute:
            return enRouteImageVew
        case .working:
            return workingImageVew
        case .tidyingUp:
            return tidyingUpImageVew
        case .finished:
            return finishedImageVew
        }
    }
    private func separatorFor(orderState:JaldiOrderState) -> JaldiOrderStateSeparatorView? {
        switch orderState {
        case .enRoute:
            return nil
        case .working:
            return workingSeparator
        case .tidyingUp:
            return tidyingUpSeparator
        case .finished:
            return finishedSeparator
        }
    }


}
