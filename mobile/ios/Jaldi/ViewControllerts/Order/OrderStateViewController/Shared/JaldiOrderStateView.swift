//
//  JaldiOrderStateView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/25/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOrderStateView: UIView {
    @IBOutlet weak var enRouteStateCheckMark: JaldiOrderStateCheckMark!
    @IBOutlet weak var workingStateCheckMark: JaldiOrderStateCheckMark!
    @IBOutlet weak var tidyingUpStateCheckMark: JaldiOrderStateCheckMark!
    @IBOutlet weak var finishedIStateCheckMark: JaldiOrderStateCheckMark!
    
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
            let stateCheckMark = self.stateCheckMarkForState(orderState: state)
            let isSelected = state.rawValue <= orderState.rawValue
            stateCheckMark.configureWith(orderState: state, isSelected: isSelected)

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
    private func stateCheckMarkForState(orderState:JaldiOrderState) -> JaldiOrderStateCheckMark {
        switch orderState {
        case .enRoute, .assigned, .created, .canceled:
            return enRouteStateCheckMark
        case .working:
            return workingStateCheckMark
        case .tidyingUp:
            return tidyingUpStateCheckMark
        case .finished:
            return finishedIStateCheckMark
        }
    }
    private func separatorFor(orderState:JaldiOrderState) -> JaldiOrderStateSeparatorView? {
        switch orderState {
        case .enRoute, .assigned, .canceled, .created:
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
