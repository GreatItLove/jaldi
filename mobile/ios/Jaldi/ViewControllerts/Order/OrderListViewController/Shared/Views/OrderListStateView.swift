//
//  OrderListStateView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/30/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class OrderListStateView: UIView {

    @IBOutlet weak var stateLabel: UILabel!
    //Mark: Configuaration
    func configureWith(orderState:JaldiOrderState) {
        self.backgroundColor = self.colorFor(orderState: orderState)
        stateLabel.text = self.titleFor(orderState: orderState)
    }
   
    private func titleFor(orderState:JaldiOrderState) -> String {
        switch orderState {
        case .created:
            return "Created"
        case .assigned:
            return "Assigned"
        case .canceled:
            return "Canceled"
        case .working:
            return "Working"
        case .tidyingUp:
            return "Tidying Up"
        case .finished:
            return "Finished"
        case .enRoute:
            return "En Route"

        }
    }
    private func colorFor(orderState:JaldiOrderState) -> UIColor {
        switch orderState {
        case .finished:
            return AppColors.orderStateGreenColor
        case .canceled:
            return AppColors.orderStateGrayColor
        default:
            return AppColors.orderStateBlueColor
        }
    }
}
