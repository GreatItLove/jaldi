//
//  UIViewController+ProgressHUD.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/20/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
extension UIViewController{
    func showHudWithMsg(message: String?){
        let hud: MBProgressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .indeterminate
        hud.label.text = message
        hud.bezelView.color = UIColor.white
        hud.label.textColor = UIColor.gray
        hud.activityIndicatorColor = AppColors.BlueColor
    }
    func hideHud(){
        MBProgressHUD.hide(for: self.view, animated: false)
    }
}
