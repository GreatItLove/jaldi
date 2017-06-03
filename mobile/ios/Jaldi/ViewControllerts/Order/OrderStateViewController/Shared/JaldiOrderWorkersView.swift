//
//  JaldiOrderWorkersView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/29/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOrderWorkersView: UIView {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var cancelView: UIView!
    
    weak var delegate:JaldiOrderStateViewControllerDelegate?
     //Mark: Configuaration
    func configureWith(order:JaldiOrder) {
       configureUserDetailsFor(order: order)
        configureOrderDetails(order: order)
     }
    private func configureUserDetailsFor(order:JaldiOrder) {
        if let user = order.user {
            fullNameLabel.text = user.name
            self.configureAvaterFor(user: user)
        }
        rateLabel.text = "4.9"
    }
    
    private func configureAvaterFor(user:JaldiUser) {
        guard let _ = user.profileImageId else {
            avatarImageView.image = AppImages.dumy_profile_pic
            return
        }
        avatarImageView.image = AppImages.dumy_profile_pic
    }
    private func configureOrderDetails(order:JaldiOrder) {
        configureOrderCost(order: order)
        configureOrderType(order: order)
        cancelView.isHidden = (order.orderState == .finished || order.orderState == .canceled)
    }
    
    private func configureOrderCost(order:JaldiOrder) {
        let cost = order.cost ?? 0
        costLabel.text = "\(Int(cost)) QAR"
    }
    private func configureOrderType(order:JaldiOrder) {
       let imageName = HomeCategoryHeleper.iconImageNameFor(category: order.homeCategory)
       serviceImageView.image = UIImage(named: imageName)
    }
    
    //Mark: Action
    @IBAction func cancelAction(_ sender: Any) {
        delegate?.orderStateViewControllerDidCancelOrder()
    }
}
