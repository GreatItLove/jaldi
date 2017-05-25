//
//  JaldiOrderStateViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/25/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit
import MapKit
class JaldiOrderStateViewController: UIViewController {

    @IBOutlet weak var orderStateView: JaldiOrderStateView!
    @IBOutlet weak var mapView: MKMapView!
    private var orderState: JaldiOrderState = JaldiOrderState.tidyingUp
    override func viewDidLoad() {
        super.viewDidLoad()
       orderStateView.configureWith(orderState: orderState)
    }
    //MARK: Actions
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }

}
