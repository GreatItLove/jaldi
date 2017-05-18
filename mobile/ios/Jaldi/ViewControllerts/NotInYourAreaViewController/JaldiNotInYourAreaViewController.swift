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
    @IBOutlet weak var backButton: UIButton!
    var presentedFromCangeZipScreen:Bool = false
    var guest: JaldiUser?
    override func viewDidLoad() {
        super.viewDidLoad()
       self.configureWith(guest: guest)
        // Do any additional setup after loading the view.
    }
    //MARK: Configurations
    private func configureWith(guest: JaldiUser?) {
        backButton.isHidden = presentedFromCangeZipScreen
        guard let guestUser = guest, let zip = guestUser.zip else {
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
        if presentedFromCangeZipScreen {
          self.dismiss(animated: true, completion: nil)
        }else{
            let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let changeZipCodeController = storyboard.instantiateViewController(withIdentifier: "JaldiChangeZipCodeController") as? JaldiChangeZipCodeController
            changeZipCodeController?.presentedFromNotInYourAreaScreen = true
            self.present(changeZipCodeController!, animated: true, completion: nil)

        }
    }
}
