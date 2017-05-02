//
//  JaldiHomeViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import UIKit

class JaldiHomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: Actions
    
    //MARK: navigate to Carpenter, Electrician, Mason, Painter, Plumber, Ac Technical
    
    @IBAction func navigateToCarpenter(_ sender: Any) {
        print("Navigate to Carpenter")
    }
    
    @IBAction func navigateToElectrician(_ sender: Any) {
        print("Navigate to Electrician")
    }
    
    @IBAction func navigateToMason(_ sender: Any) {
        print("Navigate to Mason")
    }
    
    @IBAction func navigateToPainter(_ sender: Any) {
        print("Navigate to Painter")
    }
    
    @IBAction func navigateToPlumber(_ sender: Any) {
        print("Navigate to Plumber")
    }
    
    @IBAction func navigateToAcTechnical(_ sender: Any) {
        print("Navigate to Technical")
    }
    
}
