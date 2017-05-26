//
//  JaldiBookingTimePickerViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/5/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiBookingTimePickerViewController: UIViewController,BookingNavigation {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    @IBOutlet weak var bookingTimeTitleLabel: UILabel!
    var curretScreen: BookingScreen = BookingScreen.time
    var bookingObject:BookingObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDateTimePicker()
        self.configureBookingProgress()
        configureTitleLabel()
    }
    //MARK: Confifuration
    private func configureTitleLabel() {
        bookingTimeTitleLabel.text = BookingHelper.timeDefaultTitle
    }
   
    private func configureDateTimePicker() {
        dateTimePicker.backgroundColor = UIColor.white
        if let bookingDate = bookingObject?.bookingTime {
            dateTimePicker.date = bookingDate
        }else{
            dateTimePicker.date = Date()
        }
    }
    //MARK: Actions
    @IBAction func backAction(_ sender: Any) {
        bookingObject?.bookingTime = dateTimePicker?.date
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        bookingObject?.bookingTime = dateTimePicker?.date
        self.showNextScreen()
    }
    
    private func showNextScreen() {
        if !self.isLastScreen() {
            if let nextViewController = self.nextScreen() {
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
    }
}
