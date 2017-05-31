//
//  OrderListStateView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/30/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class OrderListStateView: UIView {

    let blueColor = UIColor(red: 67/256.0, green: 176/256.0, blue: 208/256.0, alpha: 1)//43b0d0
    let greenColor = UIColor(red: 118/256.0, green: 206/256.0, blue: 103/256.0, alpha: 1)//76ce67
    @IBOutlet weak var stateLabel: UILabel!
    //Mark: Configuaration
    func configureWith(orderState:JaldiOrderState) {
        self.backgroundColor = self.colorFor(orderState: orderState)
        stateLabel.text = self.titleFor(orderState: orderState)
    }
   
    private func titleFor(orderState:JaldiOrderState) -> String {
        switch orderState {
        case .working:
            return "Working"
        case .enRoute:
            return "Created"
        case .tidyingUp:
            return "Tidying Up"
        case .finished:
            return "Finished"
        }
    }
    private func colorFor(orderState:JaldiOrderState) -> UIColor {
        
        let color  = orderState == .finished ? AppColors.orderStateGreenColor : AppColors.orderStateBlueColor
        return color
    }
}
