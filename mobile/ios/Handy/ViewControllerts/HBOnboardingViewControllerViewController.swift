//
//  HBOnboardingViewControllerViewController.swift
//  Handy
//
//  Created by Grigori Jlavyan on 4/29/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class HBOnboardingViewControllerViewController: UIViewController {
 @IBOutlet weak var theScrollView: UILabel!
    @IBOutlet weak var introView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    enum OnBoardingState: Int {
        case zip
        case email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Actions
   
   
    @IBAction func backAction(_ sender: Any) {
    }
    
    @IBAction func signInAction(_ sender: Any) {
    }
}
