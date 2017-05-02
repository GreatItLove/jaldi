//
//  JaldiNotInYourAreaViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/1/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiNotInYourAreaViewController: UIViewController {

    @IBOutlet weak var zipCodeLabel: UILabel!
    var onboardingModel: JaldiOnboardingModel?
    override func viewDidLoad() {
        super.viewDidLoad()
       self.configureWith(onboardingModel: onboardingModel)
        // Do any additional setup after loading the view.
    }
    //MARK: Configurations
    private func configureWith(onboardingModel: JaldiOnboardingModel?) {
        guard let onboarding = onboardingModel, let zip = onboarding.zip else {
            zipCodeLabel.text = "Unknown ZIP Code"
            return
        }
        zipCodeLabel.text = "ZIP Code: \(zip)"
    }
    //MARK: Actions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tryAnotherZipAction(_ sender: Any) {
        print("tryAnotherZipAction")
    }
}
