//
//  JaldiBookingContactInfoViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/5/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import UIKit

class JaldiBookingContactInfoViewController: UIViewController,BookingNavigation {

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var aptTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var bookingDatePriceView: JaldiBookingDatePriceView!
    
    
    @IBOutlet weak var changeButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressView: UIProgressView!
    var bookingObject:BookingObject?
    var curretScreen: BookingScreen = BookingScreen.contactInfo
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBookingProgress()
        addNotification()
        configureContactInfo()
        configureContactInfoTextFields()
        
    }
    //MARK: Confifuration
    private func configureContactInfo() {
        guard let booking = bookingObject else {
            return
        }
        if booking.contactInfo == nil {
            booking.contactInfo = BookingContactInfo()
        }
        bookingDatePriceView.configureWith(bookingObject: booking)
        
    }
    private func configureContactInfoTextFields() {
        fullNameTextField.text = bookingObject?.contactInfo?.fullName
        streetTextField.text = bookingObject?.contactInfo?.streetAddress
        aptTextField.text = bookingObject?.contactInfo?.apt
        phoneTextField.text = bookingObject?.contactInfo?.phone
    }
    private func updateBookingObjectFromScreen() {
        bookingObject?.contactInfo?.fullName = fullNameTextField.text
        bookingObject?.contactInfo?.streetAddress = streetTextField.text
        bookingObject?.contactInfo?.apt = aptTextField.text
        bookingObject?.contactInfo?.phone = phoneTextField.text
    }
    
    //MARK: Actions
    @IBAction func backAction(_ sender: Any) {
        self.updateBookingObjectFromScreen()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextAction(_ sender: Any) {
        self.updateBookingObjectFromScreen()
        self.showNextScreen()
    }
    
    private func showNextScreen() {
        if !self.isLastScreen() {
            if let nextViewController = self.nextScreen() {
                self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
    }
    
    //MARK: Notification
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiBookingDescriptionViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(JaldiBookingDescriptionViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func removeNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        let info = (notification as NSNotification).userInfo!
        
        let kbFrame = info[UIKeyboardFrameEndUserInfoKey]
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        let keyboardFrame = (kbFrame as? NSValue)?.cgRectValue
        let height = keyboardFrame!.size.height
        
        self.changeButtonBottomConstraint.constant = height
        
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
            
        })
    }
    
    func keyboardWillHide(_ notification:Notification) {
        let info = (notification as NSNotification).userInfo!
        let animationDuration = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        
        self.changeButtonBottomConstraint.constant = 0
        UIView.animate(withDuration: animationDuration!, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: { (finished) -> Void in
        })
    }
    
    deinit{
        removeNotification()
    }
}

//MARK: UITextFieldDelegate
extension JaldiBookingContactInfoViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let newValue = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
//        self.checkValidationAndChangeStateIfNededFor(newValue: newValue)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
}
