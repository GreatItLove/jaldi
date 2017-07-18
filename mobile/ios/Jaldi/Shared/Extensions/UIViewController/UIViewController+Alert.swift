//
//  UIViewController+Alert.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/20/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit
extension UIViewController{
    func showAlertWith(title:String?,message:String?) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
