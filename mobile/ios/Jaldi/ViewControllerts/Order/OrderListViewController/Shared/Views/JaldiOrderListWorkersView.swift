//
//  JaldiOrderListWorkersView.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/30/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiOrderListWorkersView: UIView {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var serviceImageView: UIImageView!
    
    //Mark: Configuaration
    func configureWith(order:JaldiOrder) {
        configureUserDetailsFor(order: order)
        configureOrderType(order: order)
    }
    private func configureUserDetailsFor(order:JaldiOrder) {
        let worker = order.workersList?.first
        if let user = worker?.user {
            fullNameLabel.text = user.name
            self.configureAvaterFor(user: user)
        } else {
            avatarImageView.image = AppImages.dumy_profile_pic
        }
       // rateLabel.text = worker?.rating != nil ? String(format: "%.1f", (worker?.rating)!) : ""
    }
    
    private func configureAvaterFor(user:JaldiUser) {
        guard let imageId = user.profileImageId else {
            avatarImageView.image = AppImages.dumy_profile_pic
            return
        }
        avatarImageView.downloadedFrom(link: Environment.imageBaseUrl + imageId)
    }
 
    private func configureOrderType(order:JaldiOrder) {
        let imageName = HomeCategoryHeleper.iconImageNameFor(category: order.homeCategory)
        serviceImageView.image = UIImage(named: imageName)
    }
}
