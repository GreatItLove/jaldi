//
//  JaldiSplashScreenViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/26/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiSplashScreenViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
    }
}
